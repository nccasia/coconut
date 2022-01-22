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
    baseURL: `https://${coreServer}/${organizationId}`,
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
    },
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
    },
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

async function searchWorkItems({ type, expand, apiVersion, fields }) {
  return api.post(
    `/_apis/search/workitemsearchresults`,
    {
      searchText: "",
      $skip: 0,
      $top: 1,
      filters: {
        "System.TeamProject": ["MyFirstProject"],
        "System.AreaPath": ["MyFirstProject"],
        "System.WorkItemType": ["Task"],
        "System.State": ["New", "Active", "Closed"],
        "System.AssignedTo": [],
      },
      $orderBy: [
        {
          field: "system.id",
          sortOrder: "ASC",
        },
      ],
      includeFacets: true,
    },
    {
      params: {
        "api-version": apiVersion,
        $expand: expand,
        fields,
      },
    },
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
};
