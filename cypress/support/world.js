const { setWorldConstructor, World } = require("@cucumber/cucumber");
const fs = require("fs");
let chai; let chaiAsPromised;

chai = require("chai");
chaiAsPromised = require("chai-as-promised");

chai.use(chaiAsPromised);
this.expect = chai.expect;

if (!process.env.APP_URL) {
  require("dotenv-flow").config();
}

class CustomWorld extends World {
  constructor (options) {
    // needed so `attach`, `log` and `parameters` are properly set
    super(options);
    this.data = new Map();
    this.currentScenario = null;
    this.cucumberStep = null;
    this.currentScenarioName = null;
    this.currentStepIndex = -1;
    this.example = null;
    this.startTime = new Date();
    this.endTime = new Date();
    this.myLogger = null;
    this.scenario = null;
    this.gherkinScenarioRef = null;
    this.logs = [];
  }

  attachData (dataSrc) {
    this.dataSrc = dataSrc;
    fs.readFileSync(this.dataSrc);
  }

  attachScenario (scenario) {
    this.scenario = scenario;
    this.gherkinScenarioRef = scenario.gherkinDocument.feature.children.find((s) => s.id === scenario.id);
  }

  takeScreenshot () {
    throw Error("not implemented");
  }

  attachLogger (logger) {
    this.myLogger = logger;
    this.myLogger.intercept((...args) => {
      this.logs.push(...args);
    })
  }

  detachLogger () {
    if (this.myLogger) {
      this.myLogger.clear();
    }
  }

  takeLogSnapshot () {
    this.attach(this.logs.join("\n"));
    this.logs = [];
  }
}

setWorldConstructor(CustomWorld);
