const fs = require("fs-extra");
const path = require("path");

function parseResultMeta(result) {
  const tags = result.tags;
  const meta = {};

  for (const tag of tags) {
    if (tag.name.startsWith("@TEST_PLAN_")) {
      meta.planId = tag.name.replace("TEST_PLAN_");
    }
  }

  return meta;
}

function parseResultScenarioMeta(element) {
  const tags = element.tags;

  const meta = {};

  for (const tag of tags) {
    if (tag.name.startsWith("@TEST_CASE_")) {
      meta.planId = tag.name.replace("TEST_CASE_");
    }
  }

  return meta;
}

function parseResultScenario(element) {
  element.meta = parseResultScenarioMeta(element);

  return element;
}

function parseResultScenarios(result) {
  return result.elements.map((element) => {
    return parseResultScenario(element);
  });
}

function parseResult(result) {
  result.meta = parseResultMeta(result);
  result.results = parseResultScenarios(result);

  return result;
}

function loadTestResults({ resultPath }) {
  const files = fs.readdirSync(resultPath);
  const jsons = files
    .filter((file) => file.endsWith(".json"))
    .map((file) => {
      const content = fs.readFileSync(path.join(resultPath, file));
      const json = JSON.parse(content);
      const features = json.map((feature) => {
        return parseResult(feature);
      });

      return features;
    });

  return {
    jsons,
  };
}

module.exports = {
  loadTestResults,
};
