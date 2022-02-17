const { defineParameterType } = require("cypress-cucumber-preprocessor/steps");

const randomStringTransform = function (s, verify) {
  if (s === "Empty") {
    return s
  }

  const id = Date.now();
  const data = `${s}-${id}`;

  return data;
}

defineParameterType({
  regexp: /"([^"]*)"/,
  transformer: randomStringTransform,
  name: "randomString",
  useForSnippets: false,
});

// random date
function formatDate (value) {
  let date = new Date(value);
  const day = date.toLocaleString("default", { day: "numeric" });
  const month = date.toLocaleString("default", { month: "short" });
  const year = date.toLocaleString("default", { year: "numeric" });

  return `${day}-${month}-${year}`;
}

function randomDateTransform (s) {
  if (s === "Empty") {
    return s
  }

  const start = new Date("01-01-1977");
  const end = new Date();
  const date = new Date(start.getTime() + Math.random() * (end.getTime() - start.getTime()));
  const dateStr = formatDate(date);

  return dateStr;
}

defineParameterType({
  regexp: /"([^"]*)"/,
  transformer: randomDateTransform,
  name: "randomDate",
  useForSnippets: false,
});

function arrayTransform (s) {
  if (s === "Empty") {
    return []
  }

  return typeof s === "string" ? s.split(",") : s;
}

defineParameterType({
  regexp: /"([^"]*)"/,
  transformer: arrayTransform,
  name: "array",
  useForSnippets: false,
});

function expectationTransform (s) {
  const chain = s.split(' ').join('.');

  return [chain];
}

defineParameterType({
  regexp: /[\s\S]*/,
  transformer: expectationTransform,
  name: "expectation",
  useForSnippets: false,
});

function invocationTransform (s) {
  return [s];
}

defineParameterType({
  regexp: /[\s\S]*/,
  transformer: invocationTransform,
  name: "invocation",
  useForSnippets: false,
});

function selectorTransform (s) {
  cy.get(s).as('element');

  return s;
}

defineParameterType({
  regexp: /"([^"]*)"/,
  transformer: selectorTransform,
  name: "selector",
  useForSnippets: false,
});
