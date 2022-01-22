/// <reference types="cypress" />

import { Given, Then } from "cypress-cucumber-preprocessor/steps";

Given("user visit page {string}", function (url) {
  cy.visit(url);
});

Then("user is navigated to page {string}", function (slug) {
  cy.url().should('contain', slug);
});
