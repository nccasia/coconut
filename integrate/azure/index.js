const { writeFeature, writeFixture } = require("../common");
const { parseFeature } = require("./feature-parser");
const { fetchFeatures } = require("./features-fetcher");
const { fetchParams, fetchParam } = require('./params-fetcher');
const { loadTestResults } = require("../common/results-loader/index");
const { getTestRuns, getTestResults, updateTestResult } = require("./result-uploader");
const azureApi = require("./azure-api");
const path = require("path");

async function downloadParameters(params) {
  azureApi.configure(params);
  console.log("Downloading parameters");
  const result = await fetchParams(params);

  const targetIds = result.data['ms.vss-work-web.work-item-query-data-provider']['data'].targetIds;

  for (const targetId of targetIds) {
    const res = await fetchParam({
      projectId: params.projectId,
      workItemId: targetId,
    });

    if (!res || !res.fixture || !res.automated) {
      continue;
    }

    const fileName = `${res.name}.json`;
    const outPath = path.join(path.resolve(params.fixturePath), fileName);

    console.log(`Writing fixture ${outPath}`);

    const fixture = res.fixture;

    await writeFixture(fixture, outPath);
  }
}

async function downloadFeatures(params) {
  azureApi.configure(params);
  console.log("Downloading features");
  const { suiteDetails, plan, project } = await fetchFeatures(params);

  for (const suiteDetail of suiteDetails) {
    console.log(`Parsing feature ${suiteDetail.suite.id}`);
    const feature = parseFeature(suiteDetail, plan);
    const fileName = `${project.name}_${plan.id}_${suiteDetail.suite.id}.feature`;
    const outPath = path.join(path.resolve(params.featurePath), fileName);

    console.log(`Writing feature ${outPath}`);
    await writeFeature(feature, outPath);
  }
  console.log("Downloading features succeed.");
}

async function uploadResults(params) {
  azureApi.configure(params);

  console.log("Uploading features");
  const { jsons } = await loadTestResults({
    resultPath: path.join("cypress", "results", "cucumber"),
  });

  console.log(jsons);

  const testRuns = await getTestRuns({
    projectId: params.projectId,
    automated: 'true',
  });

  const testRun = testRuns.value[0];

  const testResults = await getTestResults({ projectId: params.projectId, runId: testRun.id });

  for (const testResult of testResults.value) {
    await updateTestResult({
      projectId: params.projectId,
      runId: testRun.id,
      data: [{
        id: testResult.id,
        testCaseReferenceId: 26044,
        testCase: { id: 26044 },
        testPlan: { id: 26040 },
        testPoint: { id: 26124 },
        testSuite: { id: 26042 },
      }],
    });
  }

  console.log("Uploading features succeed.");
}

module.exports = {
  downloadFeatures,
  downloadParameters,
  uploadResults,
};
