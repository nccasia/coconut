import { Given } from 'cypress-cucumber-preprocessor/steps';
import "./data-types";

Given('user submit element {selector}',
  function (selector) {
    cy.get(selector)
      .submit();
  })
