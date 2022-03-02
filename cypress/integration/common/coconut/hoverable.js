import { Given } from "cypress-cucumber-preprocessor/steps";
import "./data-types";

Given('user hover element {string} contains {string}',
  function(selector, text) {
    cy.get(selector)
      .contains(text)
      .realHover();
  })
