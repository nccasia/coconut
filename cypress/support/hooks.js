let { After, Before, BeforeAll, BeforeStep, AfterStep, Status } = require("@cucumber/cucumber");
const log = require("./log");

const results = [];

BeforeAll(async function () {
  console.log("Starting Feature");
});

Before(async function (scenario) {
  this.attachLogger(log);
  this.attachScenario(scenario);
  this.currentScenario = scenario;
  this.cucumberStep = null;
  this.currentStepIndex = -1;
  const pickle = scenario.pickle;
  const tags = pickle.tags;
  const tagNames = tags.map((tag) => tag.name);
  const nameTag = tagNames.find((tag) => tag.startsWith("@TEST_"));

  this.currentScenarioName = nameTag;
  this.data.set("nameTag", nameTag);
  this.startTime = new Date();
  console.log(`Before scenario ${this.currentScenarioName} - ${this.currentScenario.pickle.name}`);

  const skipTag = tags.find((tag) => tag.name === "@SKIP");

  if (skipTag) {
    console.log("@SKIP tag found");
    console.log("Scenario is being skipped");

    return "skipped";
  }

  const preTags = tags.filter((tag) => tag.name.startsWith("@PRE_"));
  const preSlugs = preTags.map((preTag) => preTag.name.substring(5));
  const passedScenarios = results.filter((res) => res.result.status === Status.PASSED);
  const passedSlugs = passedScenarios.map((res) => {
    const resPickle = res.pickle;
    const resTags = resPickle.tags;
    const resTagNames = resTags.map((tag) => tag.name);
    const resNameTag = resTagNames.find((tag) => tag.startsWith("@TEST_"));
    const resNameSlug = resNameTag.substring(6);

    return resNameSlug;
  });

  for (const preSlug of preSlugs) {
    console.log("@PRE_ tag found");
    if (!passedSlugs.includes(preSlug)) {
      const preSlugsStr = preSlugs.sort().join(",");
      const passedSlugsStr = passedSlugs.sort().join(", ");

      console.log(`Pre-condition failed required: (${preSlugsStr}) but got (${passedSlugsStr})`);
      console.log("Scenario is being skipped");

      return "skipped";
    }
  }

  const dataTag = tags.find((tag) => tag.name === "@DATA");

  if (dataTag) {
    const dataSrc = dataTag.split(":");

    this.attachData(dataSrc);
  }
});

BeforeStep(function () {
  this.currentStepIndex += 1;
  this.cucumberStep = this.currentScenario.pickle.steps[this.currentStepIndex];
  console.log(`Before Step ${this.currentStepIndex} - ${this.cucumberStep.text}`);
});

AfterStep(function (scenario) {
  console.log(`After Step ${this.currentStepIndex} - ${this.cucumberStep.text} - ${Status[scenario.result.status]}`);
})

After(function (scenario) {
  if (scenario.result.status === Status.SKIPPED) {
    return "skipped";
  }

  let world = this;

  this.endTime = new Date();
  console.log("Test start at:", this.startTime.toLocaleTimeString());
  console.log("Test end at:", this.endTime.toLocaleTimeString());
  console.log("Test duration:");
  console.log("World data:", world.data);
  console.log(`After scenario ${this.currentScenarioName} - ${this.currentScenario.pickle.name} - ${Status[scenario.result.status]}`);
  results.push(scenario);

  return Promise.resolve()
    .then(function () {
      world.takeLogSnapshot();
      world.detachLogger();
    })
    .then(function () {
      if (scenario.result.status === Status.PASSED) {
        return true;
      }

      return world.takeScreenshot();
    });
});
