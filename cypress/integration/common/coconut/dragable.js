import { Given } from "cypress-cucumber-preprocessor/steps";

Given("user drag {string} and drop into {string}", function (eleDrag, eleDrop) {
  const dataTransfer = new DataTransfer()

  cy.get(`${eleDrag}`).trigger('dragstart', {
    dataTransfer,
  });

  cy.get(`${eleDrop}`).trigger('drop', {
    dataTransfer,
  });
})
