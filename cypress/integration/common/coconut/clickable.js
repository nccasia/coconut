/// <reference types="cypress" />

import { Given } from "cypress-cucumber-preprocessor/steps";

Given(
  "user click on button {string}",
  function (text) {
    cy.findAllByDisplayValue(text).click();
  },
);

Given(
  "user click on submit button {string}",
  function (text) {
    cy.get(`input[value='${text}']`).click();
  },
);

Given(
  "user click on button with id {string}",
  function (id) {
    cy.get(`#${id}`).click();
  },
);
