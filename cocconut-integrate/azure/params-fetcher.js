const api = require("./azure-api");
const parse = require("xml-parser");
const { parseWorkItem } = require('./feature-parser');

function parseDataRow(row, index) {
  return row.children.reduce((res, cell) => {
    return {
      ...res,
      [cell.attributes.key]: cell.attributes.value,
    };
  }, {});
}

function parseSharedParameters(localDataSource) {
  const parsed = parse(localDataSource);

  if (!parsed || !parsed.root || !parsed.root.children) {
    return null;
  }

  const head = parsed.root.children
    .find((child) => child.name === "paramNames")

  const headers = head.children.map((par) => par.content)
    .filter((header) => !!header);

  const data = parsed.root.children
    .find((child) => child.name === "paramData")

  const dataRows = data.children
    .map(parseDataRow)
    .filter((row) => Object.values(row).length > 0);

  return {
    dataRows,
    headers,
  };
}

async function fetchParams(params) {
  const response = await api.searchWorkItems({
    projectId: params.projectId,
    coreServer: params.coreServer,
    organizationId: params.organizationId,
    apiVersion: "5.1-preview",
  });

  return response.data;
}

function parseFixture(params) {
  if(!params || !params.headers || !params.dataRows || params.headers.length === 0 || params.dataRows.length === 0) {
    return null;
  }

  const hasKey = params.headers.includes('key');

  if(!hasKey) {
    return params.dataRows;
  }

  const data = params.dataRows.reduce((acc, curr) => {
    return {
      ...acc,
      [curr.key]: curr,
    };
  }, {});

  return data;
}

async function fetchParam({ projectId, workItemId, expand, apiVersion }) {
  const response = await api.getWorkItem({
    projectId,
    workItemId,
    expand: "relations",
    apiVersion: "5.0",
  });

  const workItem = parseWorkItem(response.data);

  const title = workItem.title;
  const tags = workItem.tags;
  const name = title.replace(/ /gm, '_');
  const paramsRaw = response.data.fields['Microsoft.VSTS.TCM.Parameters'];
  const params = parseSharedParameters(paramsRaw);
  const automated = tags.includes('Automated');
  const fixture = parseFixture(params);

  return {
    title,
    automated,
    tags,
    name,
    params,
    fixture,
  };
}

module.exports = {

  fetchParams,
  fetchParam,
};
