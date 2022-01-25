const { writeFeature } = require("../common");
const { parseFeature } = require("./feature-parser");
const { fetchFeatures } = require("./features-fetcher");
const path = require('path');

async function downloadFeatures(params) {
  console.log("Downloading features");
  const { suiteDetails, plan, project } = await fetchFeatures(params);

  for (const suiteDetail of suiteDetails) {
    console.log(`Parsing feature ${suiteDetail.suite.id}`);
    const feature = parseFeature(suiteDetail, plan);
    const fileName = `${project.name}_${plan.id}_${suiteDetail.suite.id}.feature`
    const outPath = path.join(path.resolve(params.featurePath), fileName);

    console.log(`Writing feature ${outPath}`);
    await writeFeature(feature, outPath);
  }
  console.log("Downloading features succeed.");
}

module.exports = {
  downloadFeatures,
}
