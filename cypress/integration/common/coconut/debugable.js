import { Given } from 'cypress-cucumber-preprocessor/steps';

Given('user take screenshot',
  function () {
    cy.screenshot();
  })
