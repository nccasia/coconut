/// <reference types="cypress" />

import { Given } from "cypress-cucumber-preprocessor/steps";

Given(
  "user value {string} into input with label {string}",
  function (value, label) {
    cy.findByLabelText(label).type(value);
  },
);

Given(
  "user enter {string} into field {selector}",
  function (value, selector) {
    cy.get(`${selector}`).type(value);
  },
);

Given(
  "user enter {string} into input with id {string}",
  function (value, id) {
    cy.get(`#${id}`).type(value);
  },
);

Given(
  "user enter {string} into field by id {string}",
  function (value, id) {
    cy.get(`#${id}`).type(value);
  },
);

Given(
  "user enter {string} into field by placeholder {string}",
  function (value, placeholder) {
    cy.findAllByPlaceholderText(placeholder).type(value);
  },
)

// Given(
//   "user enter {string} into field by name {string}",
//   function (value, name) {
//     if (value) {
//       cy.get(`input[name="${name}"]`).type(value);
//     }

//     cy.get(`input[name="${name}"]`);
//   },
// );

Given(
  "user enter {string} into field by name {selector}",
  function (value, selector) {
    if (value) {
      cy.get(selector).type(value);
    }

    cy.get(selector);
  },
);

Given(
  "user enter {string} into field by class {string}",
  function (value, className) {
    if (value) {
      cy.get(`.${className}`).type(value);
    }

    cy.get(`.${className}`).type(value);
  },
)

Given("user clear field by name {string}",
  function (name) {
    cy.get(`input[name="${name}"]`).clear();
  })

Given("user clear field by id {string}",
  function (id) {
    cy.get(`#${id}`).clear();
  })

Given("user clear field by class {string}",
  function (className) {
    cy.get(`.${className}`).clear();
  })

Given("user clear field {string}",
  function (selector) {
    cy.get(`${selector}`).clear();
  })
