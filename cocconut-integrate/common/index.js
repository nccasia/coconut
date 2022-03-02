const fs = require('fs');
const path = require('path');
const { compileDoc } = require('./coconut-gherkins');

const featureTemplatePath = path.join(__dirname, 'coconut-gherkins', 'default.feature.hbs');

const templateStr = fs.readFileSync(featureTemplatePath, 'utf-8');

function writeFeature(feature, outPath) {
  const featureDoc = compileDoc(templateStr, feature);

  fs.writeFileSync(outPath, featureDoc);
}

function writeFixture(fixture, outPath) {
  fs.writeFileSync(outPath, JSON.stringify(fixture));
}

module.exports = {
  writeFeature,
  writeFixture,
}
