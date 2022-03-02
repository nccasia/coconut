import { Given } from "cypress-cucumber-preprocessor/steps";
import "./data-types";

Given(
  "set element {selector} as alias {string}",
  function (selector, text) {
    cy.get(selector).as(text)
  },
);
