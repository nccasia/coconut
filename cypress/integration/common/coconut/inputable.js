/// <reference types="cypress" />

import { Given } from "cypress-cucumber-preprocessor/steps";

Given(
  "user value {string} into input with label {string}",
  function (value, label) {
    cy.findByLabelText(label).type(value);
  },
);

Given(
  "user enter {string} into input with id {string}",
  function (value, id) {
    cy.get(`#${id}`).type(value);
  },
);

Given(
  "user enter {string} into field with placeholder {string}",
  function (value , placeholder) {
    cy.findAllByPlaceholderText(placeholder).type(value);
  }
)

Given(
  "user enter {string} into filed with name {string}",
  function (value, name) {
    if(value){
      cy.get(`input[name="${name}"]`).type(value);
    }
    cy.get(`input[name="${name}"]`);
  },
);

Given("user clear and update {string} into filed with name {string}",
function(value,name){
  if(value){
    cy.get(`input[name="${name}"]`).clear().type(value);
  }else 
  cy.get(`input[name="${name}"]`).clear();

})
