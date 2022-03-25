const axios = require("axios").default;

/**
 * @type {import('axios').AxiosInstance}
 */
let api = null;

/**
 *
 * @type {import('axios').AxiosRequestConfig} options
 */
function configure({
  coreServer,
  organizationId,
  projectId,
  apiVersion,
  user,
  token,
}) {
  api = axios.create({
    baseURL: `${coreServer}/${organizationId}`,
    auth: {
      username: user,
      password: token,
    },
    params: {
      "api-version": apiVersion,
    },
  });

  api.interceptors.request.use(
    (config) => {
      return config;
    },
    (error) => {
      return Promise.reject(error);
    }
  );
}

async function getProject({
  projectId,
  includeCapabilities,
  includeHistory,
  apiVersion,
}) {
  return api.get(`/_apis//projects/${projectId}`, {
    params: {
      "api-version": apiVersion,
      includeHistory,
      includeCapabilities,
    },
  });
}

async function getTestPlan({ projectId, testPlanId, apiVersion }) {
  return api.get(`/${projectId}/_apis/testplan/plans/${testPlanId}`, {
    params: {
      "api-version": apiVersion,
    },
  });
}

async function getTestSuites({
  projectId,
  testPlanId,
  apiVersion,
  expand,
  continuationToken,
  asTreeView,
}) {
  return api.get(`/${projectId}/_apis/testplan/Plans/${testPlanId}/suites`, {
    params: {
      expand,
      asTreeView,
      continuationToken,
      "api-version": apiVersion,
    },
  });
}

async function getTestCases({ projectId, testPlanId, suiteId, apiVersion }) {
  return api.get(
    `/${projectId}/_apis/test/Plans/${testPlanId}/suites/${suiteId}/testcases`,
    {
      params: {
        "api-version": apiVersion,
      },
    }
  );
}

async function getWorkItem({ projectId, workItemId, expand, apiVersion, url }) {
  return api.get(url || `/${projectId}/_apis/wit/workitems/${workItemId}`, {
    params: {
      "api-version": apiVersion,
      $expand: expand,
    },
  });
}

async function searchWorkItems({ projectId, coreServer, organizationId, apiVersion }) {
  return api.post(
    `/_apis/Contribution/dataProviders/query`,
    {
      contributionIds: ["ms.vss-work-web.work-item-query-data-provider"],
      context: {
        properties: {
          wiql: "Select [System.Id], [System.Title] FROM WorkItems where [System.TeamProject] = @project AND System.WorkItemType in GROUP 'Microsoft.SharedParameterCategory' ORDER BY [System.Title]",
          pageSource: {
            contributionPaths: [
              "VSS",
              "VSS/Resources",
              "q",
              "knockout",
              "mousetrap",
              "mustache",
              "react",
              "react-dom",
              "react-transition-group",
              "jQueryUI",
              "jquery",
              "OfficeFabric",
              "tslib",
              "@uifabric",
              "VSSUI",
              "ContentRendering",
              "ContentRendering/Resources",
              "TFSUI",
              "TFSUI/Resources",
              "Charts",
              "Charts/Resources",
              "WidgetComponents",
              "WidgetComponents/Resources",
              "TFS",
              "Notifications",
              "Presentation/Scripts/marked",
              "Presentation/Scripts/URI",
              "Presentation/Scripts/punycode",
              "Presentation/Scripts/IPv6",
              "Presentation/Scripts/SecondLevelDomains",
              "highcharts",
              "highcharts/highcharts-more",
              "highcharts/modules/accessibility",
              "highcharts/modules/heatmap",
              "highcharts/modules/funnel",
              "Analytics",
            ],
            selectedHubGroupId: "ms.vss-test-web.test-hub-group",
            selectedHubId: "ms.vss-testmanager-web.testmanager-parameters-hub",
            url: `${coreServer}/${organizationId}/${projectId}/_testManagement/sharedParameters`,
          },
          sourcePage: {
            url: `${coreServer}/${organizationId}/${projectId}/_testManagement/sharedParameters`,
            routeId: "ms.vss-testmanager-web.testmanager-parameters-route",
            routeValues: {
              project: projectId,
              controller: "testManagement",
              action: "sharedParameters",
            },
          },
        },
      },
    },
    {
      params: {
        "api-version": apiVersion,
      },
    },
  );
}

function createTestRun({
  apiVersion,
  projectId,
  data: { automated, buildId, planId },
}) {
  return api.post(
    `/${projectId}/_apis/test/runs`,
    {
      automated,
      build: {
        id: buildId,
      },
      plan: {
        id: planId,
      },
    },
    {
      apiVersion,
    }
  );
}

function createTestResult({ apiVersion, projectId, runId, data }) {
  return api.post(`/${projectId}/_apis/test/Runs/${runId}/results`, data, {
    apiVersion,
  });
}

function getTestRuns({
  projectId,
  buildUri,
  owner,
  tmiRunId,
  planId,
  includeRunDetails,
  automated,
  skip,
  top,
  apiVersion,
}) {
  return api.get(`${projectId}/_apis/test/runs`, {
    params: {
      buildUri,
      owner,
      tmiRunId,
      planId,
      includeRunDetails,
      automated,
      skip,
      top,
      apiVersion,
    },
  });
}

function getTestResults({
  projectId,
  runId,
  apiVersion,
  detailsToInclude,
  skip,
  top,
  outcomes,
}) {
  return api.get(`${projectId}/_apis/test/Runs/${runId}/results`, {
    params: {
      detailsToInclude,
      skip,
      outcomes,
      top,
      apiVersion,
    },
  });
}

function updateTestResult({ projectId, runId, apiVersion, data }) {
  return api.patch(`/${projectId}/_apis/test/Runs/${runId}/results`, data, {
    validateStatus: false,
    params: {
      apiVersion,
    },
  });
}

function getTestPoints({
  projectId,
  planId,
  suiteId,
  apiVersion,
  testPointIds,
  testCaseId,
  continuationToken,
  returnIdentityRef,
  includePointDetails,
}) {
  return api.get(
    `/${projectId}/_apis/testplan/Plans/${planId}/Suites/${suiteId}/TestPoint`,
    {
      validateStatus: false,
      params: {
        testPointIds,
        testCaseId,
        continuationToken,
        returnIdentityRef,
        includePointDetails,
        "api-version": apiVersion,
      },
    }
  );
}

module.exports = {
  getProject,
  getTestPlan,
  getTestSuites,
  getTestCases,
  getWorkItem,
  searchWorkItems,
  configure,
  createTestRun,
  getTestRuns,
  getTestResults,
  createTestResult,
  updateTestResult,
  getTestPoints,
};
