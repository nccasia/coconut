import { Given } from "cypress-cucumber-preprocessor/steps";
import "./data-types"

Given('user select file {array} into {selector}',
  function (array, selector) {
    cy.get(selector).attachFile(array)
  })
