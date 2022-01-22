let interceptFn = null;

console.originalLog = console.log;

function log (...args) {
  console.originalLog(...args);
  pushIntercept(...args);
}

function formatLog (msg) {
  try {
    const content = ["string", "number", "boolean"].includes(typeof msg) ? msg : JSON.stringify(msg);

    return content;
  } catch (e) {
    return msg;
  }
}

function pushIntercept (...args) {
  const msgs = args.map((msg) => formatLog(msg));
  const timestamp = new Date().toLocaleTimeString();
  const sentence = msgs.join(" ");
  const prettySentence = `${timestamp}: ${sentence}`;

  if (typeof interceptFn === "function") {
    interceptFn(prettySentence);
  }
}

function clear () {
  interceptFn = null;
}

function init () {
  console.log("Console log intercepted.");
  console.log = log;
}

function intercept (logFn) {
  interceptFn = logFn;
}

module.exports = {
  init,
  log,
  clear,
  intercept,
}
