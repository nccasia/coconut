import { Given } from 'cypress-cucumber-preprocessor/steps';
import "./data-types";

Given('user check element {selector}',
  function (selector) {
    cy.get(selector)
    .check({ force: true });
  })

Given('user uncheck element {selector}',
  function (selector) {
    cy.get(selector)
    .uncheck();
  })
