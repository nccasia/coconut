const report = require("multiple-cucumber-html-reporter");
const cucumberJunitConvert = require("cucumber-junit-convert");
const fs = require("fs-extra");
const path = require("path");

const cucumberJsonDir = path.resolve(process.cwd(), "cypress/results/cucumber");
const cucumberReportFileMap = {};
const cucumberReportMap = {};
const jsonIndentLevel = 2;
const htmlReportDir = path.resolve(process.cwd(), "cypress/results/report");
const junitReportDir = path.resolve(process.cwd(), "cypress/results/junit");
const screenshotsDir = path.resolve(
  process.cwd(),
  "cypress/results/screenshots",
);

getCucumberReportMaps();
addScreenshots();
generateReport();
generateJunitReports();

function getCucumberReportMaps() {
  // eslint-disable-next-line no-undef
  filenames = fs.readdirSync(cucumberJsonDir);
  const files = fs.readdirSync(cucumberJsonDir).filter((file) => {
    return file.indexOf(".json") > -1;
  });

  files.forEach((file) => {
    const json = JSON.parse(fs.readFileSync(path.join(cucumberJsonDir, file)));

    if (!json[0]) {
      return;
    }

    const [feature] = json[0].uri.split("/").reverse();

    cucumberReportFileMap[feature] = file;
    cucumberReportMap[feature] = json;
  });
}

function addScreenshots() {
  if (fs.existsSync(screenshotsDir)) {
    //only if screenshots exists
    const prependPathSegment = (pathSegment) => {
      return (location) => {
        return path.join(pathSegment, location);
      };
    };

    const readdirPreserveRelativePath = (location) => {
      return fs.readdirSync(location).map(prependPathSegment(location));
    };

    const readdirRecursive = (location) => {
      return readdirPreserveRelativePath(location).reduce(
        (result, currentValue) => {
          return fs.statSync(currentValue).isDirectory()
            ? result.concat(readdirRecursive(currentValue))
            : result.concat(currentValue);
        },
        [],
      );
    };

    const screenshots = readdirRecursive(path.resolve(screenshotsDir)).filter(
      (file) => {
        return file.indexOf(".png") > -1;
      },
    );

    const featuresList = Array.from(
      new Set(screenshots.map((x) => x.match(/[\w-_.]+.feature/g)[0])),
    );

    featuresList.forEach((feature) => {
      screenshots.forEach((screenshot) => {
        const regex =
          /(?<=--\ ).+?((?=\ (example\ #\d+))|(?=\ (failed))|(?=.\w{3}))/g;
        // eslint-disable-next-line no-unused-vars
        const [scenarioName] = screenshot.match(regex);

        let filename = screenshot.replace(/^.*[\\\/]/, "");

        const featureSelected = cucumberReportMap[feature][0];

        let myScenarios = [];

        cucumberReportMap[feature][0].elements.forEach((item) => {
          let fullFileName = `${featureSelected.name} -- ${item.name}`;

          if (filename.includes(fullFileName)) {
            myScenarios.push(item);
          }
        });

        if (!myScenarios) {
          return;
        }

        let foundFailedStep = false;

        myScenarios.forEach((myScenario) => {
          if (foundFailedStep) {
            return;
          }

          let myStep;

          if (screenshot.includes("(failed)")) {
            myStep = myScenario.steps.find(
              (step) => step.result.status === "failed",
            );
          } else {
            myStep = myScenario.steps.find(
              (step) => step.result.status === "passed",
            );
          }

          if (!myStep) {
            return;
          }

          const data = fs.readFileSync(path.resolve(screenshot));

          if (data) {
            const base64Image = Buffer.from(data, "binary").toString("base64");

            if (!myStep.embeddings) {
              myStep.embeddings = [];
              myStep.embeddings.push({
                data: base64Image,
                mime_type: "image/png",
                name: myStep.name,
              });

              foundFailedStep = true;
            }
          }
        });

        //Write JSON with screenshot back to report file.
        fs.writeFileSync(
          path.join(cucumberJsonDir, cucumberReportFileMap[feature]),
          JSON.stringify(cucumberReportMap[feature], null, jsonIndentLevel),
        );
      });
    });
  }
}

function generateJunitReports() {
  console.log('Generating Junit report.');
  // eslint-disable-next-line no-undef
  filenames = fs.readdirSync(cucumberJsonDir);
  const files = fs.readdirSync(cucumberJsonDir).filter((file) => {
    return file.indexOf(".json") > -1;
  });

  files.forEach((file) => {
    const json = JSON.parse(fs.readFileSync(path.join(cucumberJsonDir, file)));

    if (!json[0]) {
      return;
    }

    console.log(path.join(cucumberJsonDir, file));
    console.log(`Converting ${file} to junit format`)
    cucumberJunitConvert.convert({
      inputJsonFile: path.join(cucumberJsonDir, file),
      outputXmlFile: path.join(junitReportDir, `${file}.xml`),
    });
  });
}

function generateReport() {
  console.log('Generating html report');
  if (!fs.existsSync(cucumberJsonDir)) {
    console.warn("REPORT CANNOT BE CREATED!");
  } else {
    report.generate({
      jsonDir: cucumberJsonDir,
      reportPath: htmlReportDir,
      displayDuration: true,
      useCDN: true,
      pageTitle: "Simulacion de Credito Online",
      reportName: `Simulacion de Credito Online - ${new Date().toLocaleString()}`,
      metadata: {
        app: {
          name: "Simulacion de Credito Online",
          version: "1",
        },
        browser: {
          name: "electron",
        },
        device: "EMULATOR",
        platform: {
          name: "linux",
        },
      },
      customData: {
        title: "Run info",
        data: [
          { label: "Project", value: "Simulacion de Credito" },
          { label: "Release", value: "1" },
          {
            label: "Execution Start Time",
            value: `${new Date().toLocaleString()}`,
          },
          {
            label: "Execution End Time",
            value: `${new Date().toLocaleString()}`,
          },
        ],
      },
    });
  }
}
