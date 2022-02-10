import { Given } from 'cypress-cucumber-preprocessor/steps';
import "./data-types";

Given('user focus element {selector} contains {string}',
  function (selector, text) {
    cy.get(selector).contains(text).focus()
  })

Given('user blur element {selector} contains {string}',
  function (selector, text) {
    cy.get(selector).contains(text).blur()
  })
