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
