const { renderTable } = require("./common");
const flatten = require("flat");

function myFlatten(raw) {
  const dat = {};

  for (const [key, val] of Object.entries(raw)) {
    if (Array.isArray(val)) {
      dat[key] = val.join(",");
    } else if (typeof val === "object") {
      dat[key] = myFlatten(val);
    } else {
      dat[key] = val;
    }
  }

  return flatten(dat);
}

function examplePartial(args) {
  const data = args.data;
  const dataArray = Array.isArray(data) ? data : [data];
  const flattenData = dataArray.map((dat) => myFlatten(dat));
  const headers = Object.keys(flattenData[0]);
  const rows = flattenData.map((dat) => headers.map((head) => dat[head]));

  const exampleTable = renderTable(headers, rows);

  return `Examples: ${args.name}\n${exampleTable}`;
}

module.exports = {
  examplePartial,
};
