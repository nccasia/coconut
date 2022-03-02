import { And } from "cypress-cucumber-preprocessor/steps";
import "./data-types";

And(
  "it's {invocation} {string} should {expectation} {string}",
  function (extraction, name, expectation, value) {
    cy.get("@element")
        .invoke(...extraction, name)
        .should(...expectation, value);
  },
);

And(
  "it's {invocation} {string} should {expectation}",
  function (extraction, name, expectation) {
    cy.get("@element")
        .invoke(...extraction, name)
        .should(...expectation);
  },
);

And(
  "it's {invocation} should {expectation} {string}",
  function (extraction, expectation, value) {
    cy.get("@element")
      .invoke(...extraction)
      .should(...expectation, value);
  },
);

And(
  "it's should {expectation} {string}",
  function (expectation, value) {
    cy.get("@element")
      .should(...expectation, value);
  },
);

And(
  "it's {invocation} should {expectation}",
  function (extraction, expectation) {
    cy.get("@element")
      .invoke(...extraction)
      .should(...expectation);
  },
);

And(
  "element {selector} should {expectation} {string} {string}",
  function(selector, expectation, name, value) {
    cy.get(selector)
    .should(...expectation, name, value)
  },
)

And(
  "element {selector} should {expectation} {string}",
  function(selector, expectation, value) {
    cy.get(selector)
    .should(...expectation, value)
  },
)

And(
  "element {selector} should {expectation}",
  function (selector, expectation) {
    cy.get(selector)
      .should(...expectation);
  },
);

And("extract {selector} {invocation} as alias {string}",
  function(selector, extraction, alias) {
    cy.get(selector).invoke(...extraction).as(alias);
  })
