/// <reference types="cypress" />

import { Given } from "cypress-cucumber-preprocessor/steps";

Given(
  "user is able to see input with label {string}",
  function (label) {
    cy.findByLabelText(label).should('be.visible');
  },
);

Given(
  "user is able to see input with id {string}",
  function (id) {
    cy.get(`#${id}`).should('be.visible');
  },
);

Given("user is able to see element {selector}", function (selector) {
  cy.get(selector).should('be.visible');
});

Given("user is able to see element {selector} contains {string}", function (selector, text) {
  cy.get(selector).contains(text).should('be.visible');
});

Given("user is able to see element by alias {string}", function (text) {
  cy.wait(2000).get(text).should('be.visible');
});

Given("user is able to see element by tag {string} has content", function (tagName) {
  cy.get(tagName).should('be.visible');
});

Given("waiting for page loading", function () {
  cy.wait(2000);
});

Given("element by alias {string} should contains {string}", function (text, value) {
  cy.get(text).should('contain', value)
});
