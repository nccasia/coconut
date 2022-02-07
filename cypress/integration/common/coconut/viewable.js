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

Given("user is able to see element {string}", function (element) {
  cy.get(element).should('be.visible');
});

Given("user is able to see element by tag {string} has content", function (tagName) {
  cy.get(tagName).should('be.visible');
});
