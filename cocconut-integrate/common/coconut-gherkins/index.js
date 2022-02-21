const Handlebars = require("handlebars");
const fs = require("fs");
const path = require("path");
const { examplePartial } = require("./example-partial");
const { actionPartial } = require("./action-helper");
const { commentedHelper } = require("./commented-helper");
const { setVarHelper } = require("./set-var-helper");
const through = require("through");

Handlebars.registerHelper("setVar", setVarHelper);
Handlebars.registerPartial("examples", examplePartial);
Handlebars.registerHelper("action", actionPartial);
Handlebars.registerHelper("commented", commentedHelper);

function preProcessDoc(rawDoc) {
  const refinedDoc = rawDoc.replace(new RegExp("\\&", "gm"), "@");

  return refinedDoc;
}

function loadFixturesContext(fixturePath) {
  const context = {};

  const files = fs.readdirSync(fixturePath);

  for (const file of files) {
    if (file.endsWith(".json")) {
      const content = fs.readFileSync(path.resolve(fixturePath, file));
      const fixture = JSON.parse(content);
      const key = file.replace(".json", "");

      context[key] = fixture;
    }
  }

  return context;
}

function postProcessDoc(compiledDoc) {
  const fixturePath = path.resolve('cypress/fixtures')
  const context = loadFixturesContext(fixturePath);
  const resultDoc = Handlebars.compile(compiledDoc, { noEscape: true })(
    context,
  );

  return resultDoc;
}

function compileDoc(templateDoc, context) {
  const templateStr = preProcessDoc(templateDoc);
  const template = Handlebars.compile(templateStr, { noEscape: true });

  const compiledDoc = template(context);

  const postCompiledDoc = postProcessDoc(compiledDoc);

  return postCompiledDoc;
}

const filenamePattern = /\.(feature|features)$/;

const gherkinsTransform = function (file) {
  if (!filenamePattern.test(file)) return through();

  let input = "";
  const write = function (buffer) {
    input += buffer;
  };

  const end = function () {
    this.queue(compileDoc(input));
    this.queue(null);
  };

  return through(write, end);
};

module.exports = {
  gherkinsTransform,
  compileDoc,
};
