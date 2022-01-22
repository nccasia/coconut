const parse = require("xml-parser");
const { convert } = require("html-to-text");
const decode = require("decode-html");

function traverseSteps(node) {
  if (!node) {
    return [];
  }

  const result = [];

  if (node.name === "step" || node.name === "compref") {
    result.push(node);
  }

  if (node.children) {
    for (const child of node.children) {
      const res = traverseSteps(child);

      result.push(...res);
    }
  }

  return result;
}

function linkStep(step, caseDetail) {
  if (step.name !== "compref") {
    return step;
  }

  const ref = step.attributes.ref;

  step.relation = (caseDetail.relations || []).find(
    // eslint-disable-next-line eqeqeq
    (rel) => rel.workItem && rel.workItem.id == ref,
  );

  step.sharedStep = parseSharedStep(step.relation.workItem, step);

  return step;
}

function replaceParameters(message, examples) {
  const params = examples ? examples.keys.join("|") : "";

  if (!params) {
    return message;
  }

  const reg = new RegExp(`"@(${params})"`, "g");
  let result = message;
  let matched = null;

  while ((matched = reg.exec(result)) !== null) {
    result = result.replace(matched[0], `"<${matched[1]}>"`);
  }

  return result;
}

function parseStepMessage(message, examples) {
  const prettified = convert(decode(message || ""));
  const parapeted = replaceParameters(prettified, examples);

  return parapeted;
}

function parseLocalStep(step, examples) {
  const messages = [];

  for (const child of step.children) {
    const parseLocalContent = parseStepMessage(child.content, examples);

    if (parseLocalContent) {
      messages.push(parseLocalContent);
    }
  }

  step.message = messages
    .join("\n")
    .replace(/[\r\n]{2,}/g, "\n")
    .replace(/\n+$/, "");

  return step;
}

function normalizeStep(step, examples) {
  if (step.sharedStep) {
    const linkedSteps = [];

    for (const subStep of step.sharedStep.steps) {
      // TODO: check passed examples
      const linkedStep = normalizeStep(subStep, examples);

      linkedSteps.push(...linkedStep);
    }

    return linkedSteps;
  }

  if (step.name === "step") {
    const localStep = parseLocalStep(step, examples);

    return [localStep];
  }

  throw new Error("unable to parse step", step);
}

function parseSteps(rawSteps, caseDetail, examples) {
  const stepsObj = parse(rawSteps);
  const flattenSteps = traverseSteps(stepsObj.root);
  const stepWithLinked = flattenSteps.map((step) => linkStep(step, caseDetail));

  const normalized = stepWithLinked.reduce((steps, step) => {
    const newSteps = normalizeStep(step, examples);

    return [...steps, ...newSteps];
  }, []);

  return normalized;
}

function parseSharedStep(caseDetail, parent) {
  const parsedWorkItem = parseWorkItem(caseDetail);
  const meta = parseScenarioMeta(caseDetail, parsedWorkItem);
  const description = parsedWorkItem.description;
  const rawSteps = getField(caseDetail, "Microsoft.VSTS.TCM.Steps");
  const examples = parseLocalDataSource(
    getField(caseDetail, "Microsoft.VSTS.TCM.LocalDataSource"),
  );
  const steps = parseSteps(rawSteps, caseDetail, examples, parent);

  if (steps.length > 0) {
    steps[0].comment = `Shared step: ${parsedWorkItem.title} - ${parsedWorkItem.id}`;

    steps[steps.length - 1].postComment = "---";
  }

  return {
    meta,
    description,
    steps,
  };
}

function parseScenarioMeta(caseDetail, parsedWorkItem) {
  return {
    ...parsedWorkItem,
  };
}

function parseScenarioTags(caseDetail, parsedWorkItem) {
  const systemTags = parsedWorkItem.tags.map((tag) => `@${tag}`);
  const state = getField(caseDetail, "System.State");

  return [`@TEST_CASE_${caseDetail.id}`, `@STATE_${state}`, ...systemTags];
}

function parseHtml(raw) {
  const value = convert(decode(raw));

  return value;
}

function parseDataRow(row, index) {
  return row.children.reduce((res, cell) => {
    return {
      ...res,
      [cell.name]: cell.content,
    };
  }, {});
}

function parseDataSchema(schema, index) {
  // TODO: check again this messy stuff
  const headers =
    schema.children[0].children[0].children[0].children[0].children[0].children[0].children.map(
      (child) => {
        return {
          name: child.attributes.name,
        };
      },
    );
  const keys = headers.map((head) => head.name);

  return {
    headers,
    keys,
  };
}

function parseLocalDataSource(localDataSource) {
  const parsed = parse(localDataSource);

  if (!parsed || !parsed.root || !parsed.root.children) {
    return null;
  }

  const name = parsed.root.name;
  const schema = parsed.root.children.find(
    (child) => child.name === "xs:schema",
  );

  const { headers, keys } = parseDataSchema(schema);

  const data = parsed.root.children
    .filter((child) => child.name !== "xs:schema")
    .map(parseDataRow);

  return {
    name,
    headers,
    keys,
    data,
  };
}

function parseScenario(caseDetail) {
  const parsedWorkItem = parseWorkItem(caseDetail);
  const outline = getField(caseDetail, "System.Title");
  const meta = parseScenarioMeta(caseDetail, parsedWorkItem);
  const tags = parseScenarioTags(caseDetail, parsedWorkItem);
  const description = parsedWorkItem.description;
  const rawSteps = getField(caseDetail, "Microsoft.VSTS.TCM.Steps");
  const examples = parseLocalDataSource(
    getField(caseDetail, "Microsoft.VSTS.TCM.LocalDataSource"),
  );
  const steps = parseSteps(rawSteps, caseDetail, examples);

  return {
    meta,
    outline,
    tags,
    description,
    steps,
    examples,
  };
}

function parseFeatureMeta(testSuite, parsedWorkItem) {
  return {
    parentName: testSuite.suite.parentSuite.name,
    ...parsedWorkItem,
  };
}

function parseFeatureTags(testSuite, parsedWorkItem, plan) {
  const systemTags = parsedWorkItem.tags.map((tag) => `@${tag}`);

  return [
    `@TEST_PROJECT_${testSuite.suite.project.name}`,
    `@TEST_PLAN_${plan.id}`,
    `@TEST_SUITE_${testSuite.suite.id}`,
    `@TEST_SUITE_TYPE_${testSuite.suite.suiteType}`,
    ...systemTags,
  ];
}

function getField(workItem, name, def = "") {
  return workItem.fields[name] || def;
}

function parseWorkItem(workItem) {
  const tagsStr = getField(workItem, "System.Tags");
  const tags = tagsStr
    .split(",")
    .filter((tag) => !!tag)
    .map((tag) => tag.trim());
  const title = getField(workItem, "System.Title");
  const ref = workItem._links.html.href;
  const description = parseHtml(getField(workItem, "System.Description"));

  return {
    id: workItem.id,
    tags,
    title,
    ref,
    description,
  };
}

function parseFeature(testSuite, plan) {
  const name = testSuite.suite.name;
  const parsedWorkItem = parseWorkItem(testSuite.detail);
  const meta = parseFeatureMeta(testSuite, parsedWorkItem);
  const tags = parseFeatureTags(testSuite, parsedWorkItem, plan);
  const description = parsedWorkItem.description;
  const allScenarios = testSuite.cases.map(parseScenario);

  const scenarios = allScenarios.filter((sc) => sc.steps.length > 0);

  return {
    name,
    meta,
    tags,
    description,
    scenarios,
  };
}

module.exports = {
  parseFeature,
};
