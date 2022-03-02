import { Given } from "cypress-cucumber-preprocessor/steps";
import "./data-types";

Given("user drag {selector} and drop into {selector}", function (eleDrag, eleDrop) {
  const dataTransfer = new DataTransfer()

  cy.get(`${eleDrag}`).trigger('dragstart', {
    dataTransfer,
  });

  cy.get(`${eleDrop}`).trigger('drop', {
    dataTransfer,
  });
})
