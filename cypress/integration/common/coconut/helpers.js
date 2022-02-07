import { Given } from "cypress-cucumber-preprocessor/steps";

Given(
  "set {string} as alias {string}",
  function (selectorName, aliasName) {
    cy.get(selectorName).as(aliasName)
  },
);
