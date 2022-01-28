const azureApi = require("./azure-api");

async function createTestRun(result) {
  return azureApi.createTestRun({});
}

async function createTestResult(result) {
  return azureApi.createTestRun({});
}

async function getTestRuns({
  projectId,
  automated,
}) {
  const response = await azureApi.getTestRuns({
    projectId,
    automated,
    includeRunDetails: true,
  });

  return response.data;
}

async function getTestResults({
  projectId,
  runId,
}) {
  const response = await azureApi.getTestResults({
    projectId,
    runId,
    includeRunDetails: true,
  });

  return response.data;
}

async function updateTestResult({
  projectId,
  runId,
  data,
}) {
  const response = await azureApi.updateTestResult({
    projectId,
    runId,
    data,
  });

  return response.data;
}

async function getTestPoints({
  projectId,
  testCaseId,
  testPointIds,
  suiteId,
  planId,
  apiVersion,
}) {
  const response = await azureApi.getTestPoints({
    projectId,
    testCaseId,
    testPointIds,
    planId,
    suiteId,
    apiVersion,
  });
  console.log(response);
  
  return response.data;
}

module.exports = {
  createTestRun,
  createTestResult,
  getTestRuns,
  getTestResults,
  updateTestResult,
  getTestPoints,
};
