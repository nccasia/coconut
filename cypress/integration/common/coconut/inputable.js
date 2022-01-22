/// <reference types="cypress" />

import { Given } from "cypress-cucumber-preprocessor/steps";

Given(
  "user value {string} into input with label {string}",
  function (value, label) {
    cy.findByLabelText(label).type(value);
  },
);

Given(
  "user enter {string} into input with id {string}",
  function (value, id) {
    cy.get(`#${id}`).type(value);
  },
);
