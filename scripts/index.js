const { downloadFeatures, uploadTestResults, downloadParameters } = require("../cocconut-integrate");
const { program } = require("commander");

require("./env");

program
  .arguments("<task>", "task to execute", "download")
  .option("-au, --azure-user <delay>", "azure user")
  .option("-ap, --azure-project <delay>", "azure project id")
  .option("-ao, --azure-organization <delay>", "azure organization id")
  .option("-apl, --azure-plan <delay>", "azure plan id")
  .option("-as, --azure-project <delay>", "azure project id")
  .option("-at, --azure-token <delay>", "azure token")
  .parse(process.argv);

main(program.opts(), ...program.args);

async function main(options, task) {
  switch (task) {
    case "download": {
      return await downloadFeatures(options);
    }
    case "params": {
      return await downloadParameters(options);
    }
    case "upload": {
      return await uploadTestResults(options);
    }
    default:
      throw new Error(`unknown task ${task}`);
  }
}
