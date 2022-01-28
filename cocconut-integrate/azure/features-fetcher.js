const azureApi = require("./azure-api");

async function getProject({ id }) {
  const response = await azureApi.getProject({
    projectId: id,
    apiVersion: "5.0",
    includeCapabilities: true,
    includeHistory: false,
  });

  return response.data;
}

async function getTestPlan({ id, projectId }) {
  const response = await azureApi.getTestPlan({
    testPlanId: id,
    projectId,
    apiVersion: "5.0-preview",
  });

  return response.data;
}

async function getTestSuites({ testPlanId, projectId }) {
  const response = await azureApi.getTestSuites({
    testPlanId,
    projectId,
    expand: true,
    asTreeView: false,
    apiVersion: "5.0-preview.1",
  });

  return response.data.value;
}

async function getTestSuite({ projectId, workItemId }) {
  const response = await azureApi.getWorkItem({
    projectId,
    workItemId,
    expand: "relations",
    apiVersion: "5.0",
  });
  const testSuite = response.data;

  return testSuite;
}

async function getTestCases({ projectId, testPlanId, suiteId }) {
  const response = await azureApi.getTestCases({
    projectId,
    testPlanId,
    suiteId,
    apiVersion: "5.0",
  });

  return response.data.value;
}

async function getTestCase({ projectId, workItemId }) {
  const response = await azureApi.getWorkItem({
    projectId,
    workItemId,
    expand: "relations",
    apiVersion: "5.0",
  });
  const testCase = response.data;

  for (const workItem of (testCase.relations || [])) {
    if (
      ["Microsoft.VSTS.TestCase.SharedStepReferencedBy-Reverse"].includes(
        workItem.rel,
      )
    ) {
      const workItemResponse = await azureApi.getWorkItem({ url: workItem.url });

      workItem.workItem = workItemResponse.data;
    }
  }

  return response.data;
}

async function fetchFeatures(params) {
  const project = await getProject({ id: params.projectId });

  const plan = await getTestPlan({
    id: params.planId,
    projectId: params.projectId,
  });

  const suites = await getTestSuites({
    testPlanId: params.planId,
    projectId: params.projectId,
    expand: 'all',
  });

  const suiteDetails = [];

  for (const suite of suites) {
    console.log(`Downloading test suite ${suite.id}`);

    const detail = await getTestSuite({ workItemId: suite.id, projectId: params.projectId });

    const cases = await getTestCases({
      suiteId: suite.id,
      projectId: params.projectId,
      testPlanId: params.planId,
    });

    const suiteData = {
      suite,
      detail,
      cases: [],
    };

    for (const cas of cases) {
      const caseDetail = await getTestCase({
        workItemId: cas.testCase.id,
        projectId: params.projectId,
      });

      if (
        caseDetail.fields["Microsoft.VSTS.TCM.AutomationStatus"] === "Planned"
      ) {
        suiteData.cases.push(caseDetail);
      }
    }

    if (suiteData.cases.length > 0) {
      suiteDetails.push(suiteData);
    }
  }

  return {
    suiteDetails,
    project,
    plan,
  };
}

module.exports = {
  fetchFeatures,
};
