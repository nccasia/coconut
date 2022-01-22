/// <reference types="cypress" />

import { Then } from "cypress-cucumber-preprocessor/steps";

Then("the new document is created with {string}", function (title) {
  cy.findAllByText(title).should('be.visible');
});
