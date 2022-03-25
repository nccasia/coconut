const { addComments, parseTable } = require("./common");

function setVarHelper(varName, options) {
  const content = options.fn(this);
  const value = parseTable(content);
  options.data.root[varName] = value;
  const commentedContent = addComments(content);
  return commentedContent + '\n';
}

module.exports = {
  setVarHelper,
};
