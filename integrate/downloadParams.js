const azure = require('./azure');

function downloadParameters(c) {
  switch (process.env.INTEGRATE_STRATEGY) {
    case 'azure-devops': {
      return azure.downloadParameters({
        user: process.env.AZURE_USER,
        organizationId: process.env.AZURE_ORGANIZATION_ID,
        projectId: process.env.AZURE_PROJECT_ID,
        planId: process.env.AZURE_PLAN_ID,
        coreServer: process.env.AZURE_CORE_SERVER,
        token: process.env.AZURE_TOKEN,
        apiVersion: process.env.AZURE_CORE_API_VERSION,
        featurePath: process.env.FEATURE_PATH,
        fixturePath: process.env.FIXTURE_PATH,
      });
    }
    default: {
      throw new Error(`Integrate Strategy ${process.env.INTEGRATE_STRATEGY} is not supported.`)
    }
  }
}

module.exports = downloadParameters;
