var reporter = require('cucumber-html-reporter');
var fs = require('fs');
var path = require('path');

function validateJSON(body) {
  try {
    var data = JSON.parse(body);
    // if came to here, then valid
    return data;
  } catch(e) {
    // failed to parse
    return null;
  }
}
  
function validateJsonFile(filePath) {
  let rawData = fs.readFileSync(filePath);
  let valid = validateJSON(rawData);
  return valid;
}

function getAllJsonFiles(folder) {
  const files = fs.readdirSync(folder);
  const jsonFiles = files.filter(function(file) {
    return file.endsWith('.json');
  });
  return jsonFiles;
}

function tweakReportJson(content) {
  return content.map(function(ctn) {
    return {
      ...ctn,
      elements: ctn.elements.map(function(elm) {
        if(elm.steps[elm.steps.length - 2].result.status === 'skipped') {
          elm.steps[elm.steps.length - 1].result.status = 'skipped';
        }
        return elm;
      })
    }
  })
}

function fixBadJsonFiles(folder) {
  const jsonFiles = getAllJsonFiles(folder);
  for(const file of jsonFiles) {
    const filePath = path.join(folder, file);
    const json = validateJsonFile(filePath);
    if(!json) {
      fs.unlinkSync(filePath);
    } else {
      const tweakedJson = tweakReportJson(json);
      fs.writeFileSync(filePath, JSON.stringify(tweakedJson));
    }
  }
}


const JSON_DIR = 'test-reports/results';

function generateReport() {
    console.log("=======Test Report Generation=======");
    console.log('Generating test report');
    var options = {
        brandTitle: 'SIT Test',
        theme: 'bootstrap',
        jsonDir: 'test-reports/results',
        output: 'test-reports/report.html',
        reportSuiteAsScenarios: true,
        launchReport: false,
        ignoreBadJsonFile: true,
        screenshotsDirectory: 'test-reports/screenshots',
        storeScreenshots: true
    };

    fixBadJsonFiles(JSON_DIR);

    reporter.generate(options, function() {
        console.log('Generate test report successfully');
    });
}

module.exports = generateReport;