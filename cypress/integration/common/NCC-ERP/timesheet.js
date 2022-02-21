/// <reference types="cypress" />

import { When } from "cypress-cucumber-preprocessor/steps";

import "../coconut/data-types";

import "../coconut/helpers";

import "../coconut/assertions";

// When("user click on first element {selector} don't have {selector}", function (selector, value) {
//   cy.get(selector).then(($btn) => {
//     cy.wrap($btn).wait(1000).not(value)
//       .first().click()
//   })
// })

// When("user click on last element {string} don't have {selector}", function (selector, value) {
//   cy.get(selector).then(($btn) => {
//     cy.wrap($btn).wait(1000).not(value)
//       .last().click()
//   })
// })

When(
  "user click on element {selector} contains {selector} and not contains {string}",
  function (selector, value, text) {
    cy.get(selector).then(($btn) => {
      const filtered = Cypress._.filter($btn, (el) => {
        return el.querySelector(value)
      })

      return filtered
    }).wait(3000).not(`:contains(${text})`).last().as('ele').click();
  },
);

When(
  "user click on element",
  function () {
    cy.wait(1000).get('@ele').click();
  },
);

When(
  "user click on day {selector} contains {string}",
  function (selector, text) {
    let expText = text;

    if (expText.startsWith('@')) {
      const alias = expText.substring(1);

      expText = this[alias];
    }

    cy.get(selector).contains(new RegExp(expText, "g")).click()
  },
);

When("user click on sub element {selector} in element {selector} by alias {string}", function (subEle, selector, text) {
  let expText = text;

  if (expText.startsWith('@')) {
    const alias = expText.substring(1);

    expText = this[alias];
  }

  cy.get(selector).contains(expText).parents(selector).find(subEle).click();
});

When("user able to see sub element {selector} in element {selector} by alias {string}", function (subEle, selector, text) {
  let expText = text;

  if (expText.startsWith('@')) {
    const alias = expText.substring(1);

    expText = this[alias];
  }

  cy.get(selector).contains(expText).parents(selector).find(subEle).should('be.visible');
});
