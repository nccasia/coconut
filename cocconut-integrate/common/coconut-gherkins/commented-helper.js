const { addComments } = require("./common");


function commentedHelper(options) {
  const content = options.fn(this);
  const commentedContent = addComments(content);
  return commentedContent;
}

module.exports = {
  commentedHelper,
};
