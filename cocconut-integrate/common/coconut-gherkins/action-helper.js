const { addComments } = require("./common");

const actionSteps = [
  {
    pattern: '([^\s]+) user Login',
    template: `
    Given data loaded from file "abc.def"
    `
  }
]

function actionPartial(message, ...args) {
  const content = options.fn(this);
  const commentedContent = addComments(content);
  const referenced = commentedContent + ' referenced action' + '\n';

  const matchedStep = actionSteps.find(step => new RegExp(step.pattern).test(message));
  if(matchedStep) {
    return referenced + matchedStep.template;
  }
  return message;
}

module.exports = {
  actionPartial,
};
