const dotenv = require("dotenv");
const fs = require("fs");
const validate = require("dotenv-validator").default;

const example = fs.readFileSync(".env.example", "utf-8");

const { envRules, envDefault } = example.split("\n").reduce(
  (env, line) => {
    const [nameSlug, valueAndDescriptors] = line.split("=");
    const name = (nameSlug || "").trim();
    const [valueSlug, descriptorsSlug] = (valueAndDescriptors || "").split("#");
    const value = (valueSlug || "").trim();
    const descriptors = (descriptorsSlug || "")
      .trim()
      .replace("#")
      .split(",")
      .map((d) => d.toLowerCase().trim());
    const isRequired = !descriptors.includes("optional");

    env.envDefault[name] = isRequired ? value : "";
    env.envRules[name] = {
      required: isRequired,
    };

    return env;
  },
  { envRules: {}, envDefault: {} },
);

const envParsed = dotenv.config().parsed;

validate({ envParsed, envDefault, envRules });

module.exports = envParsed;
