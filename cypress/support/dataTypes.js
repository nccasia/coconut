const { defineParameterType } = require("@cucumber/cucumber");
const fs = require('fs');

const randomStringTransform = function (s, verify) {
  if (s === "Empty") {
    return s
  }

  const id = Date.now();
  const data = `${s}-${id}`;

  return data;
}

defineParameterType({
  regexp: /"([^"]*)"/,
  transformer: randomStringTransform,
  name: "randomString",
  useForSnippets: false,
});

// random date
function formatDate (value) {
  let date = new Date(value);
  const day = date.toLocaleString("default", { day: "numeric" });
  const month = date.toLocaleString("default", { month: "short" });
  const year = date.toLocaleString("default", { year: "numeric" });

  return `${day}-${month}-${year}`;
}

function randomDateTransform (s) {
  if (s === "Empty") {
    return s
  }

  const start = new Date("01-01-1977");
  const end = new Date();
  const date = new Date(start.getTime() + Math.random() * (end.getTime() - start.getTime()));
  const dateStr = formatDate(date);

  return dateStr;
}

defineParameterType({
  regexp: /"([^"]*)"/,
  transformer: randomDateTransform,
  name: "randomDate",
  useForSnippets: false,
});

function arrayTransform (s) {
  if (s === "Empty") {
    return []
  }

  return typeof s === "string" ? s.split(",") : s;
}

defineParameterType({
  regexp: /"([^"]*)"/,
  transformer: arrayTransform,
  name: "array",
  useForSnippets: false,
});

const DATA_ROOT = "features/testData/";

function fileTransform (s) {
  const fileSlugs = s.split(".");
  const fileExt = fileSlugs.pop();

  switch (fileExt) {
    case "json": {
      let json = fs.readFileSync(`${DATA_ROOT}/${s}`, "utf-8");
      let data = JSON.parse(json);

      return data
    }
    default:
      throw new Error(`data type is not supported for ${s}`);
  }
}

defineParameterType({
  regexp: /"([^"]*)"/,
  transformer: fileTransform,
  name: "file",
  useForSnippets: false,
});
