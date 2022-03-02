import { Given } from 'cypress-cucumber-preprocessor/steps';
import "./data-types";

Given('user select option {string} of element {selector} contains {string}',
  function (value, selector, text) {
    cy.get(selector)
      .select(value)
      .contains(text)
  })
