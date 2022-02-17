import { Given } from "cypress-cucumber-preprocessor/steps";
import "./data-types";

Given(
  "set {selector} as alias {string}",
  function (selectorName, aliasName) {
    cy.get(selectorName).as(aliasName)
  },
);
