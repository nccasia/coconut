/// <reference types="cypress" />

import { Given } from "cypress-cucumber-preprocessor/steps";
import "./data-types";

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
  "user click on element by id {string}",
  function (id) {
    cy.get(`#${id}`).click();
  },
);

Given(
  "user click on element by class {string}",
  function (className) {
    cy.get(`.${className}`).click();
  },
);

Given(
  "user click on element has text {string}",
  function (text) {
    cy.wait(1000)
    cy.get('button').contains(text).click()
    cy.wait(2000)
  },
);

Given(
  "user click on element {selector} contains {string}",
  function (selector, text) {
    cy.get(selector).contains(text).click()
  },
);

Given(
  "user double click on element {selector} contains {string}",
  function (selector, text) {
    cy.get(selector).contains(text).dblclick()
  },
);

Given(
  "user right click on element {selector} contains {string}",
  function (selector, text) {
    cy.get(selector).contains(text).rightclick();
  },
);

Given("user click on anchor with link {string}", function (text) {
  cy.get(`a[href*="${text}"]`).click()
});

Given("user click on element {selector}", function (selector) {
  cy.get(`${selector}`).click()
});

Given("user is able to click on element {string}", function (element) {
  cy.get(`${element}`).click()
});

Given("user is unable to click on element {string}", function (element) {
  cy.get(`${element}`)
});
