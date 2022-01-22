const Handlebars = require("handlebars");
const fs = require("fs");
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
  const refinedDoc = rawDoc;

  return refinedDoc;
}


function compileDoc(templateDoc, context) {
  const templateStr = preProcessDoc(templateDoc);
  const template = Handlebars.compile(templateStr, { noEscape: true });

  const compiledDoc = template(context);

  return compiledDoc;
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
