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

Given(
  "user click on button with class {string}",
  function (className) {
    cy.get(`.${className}`).click();
  },
);

Given(
  "user is able to click on button {string}",
  function (text) {
    cy.wait(1000)
    cy.get('button').contains(text).click()
  },
);

Given("user visit to sub page {string}", function (text) {
  cy.get(`a[href*="${text}"]`).click()
});