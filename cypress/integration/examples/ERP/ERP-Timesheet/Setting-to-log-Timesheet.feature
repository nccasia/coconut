@TEST_PROJECT_NCC-ERP @TEST_PLAN_26829 @TEST_SUITE_27427 @TEST_SUITE_TYPE_staticTestSuite 
Feature: Setting to log timesheet
Ref: https://ops.nccsoft.vn/DefaultCollection/a5caa4a9-4c73-48d6-9b3c-d2764fe3e9ff/_workitems/edit/27427


  # ###########
#    Ref: https://ops.nccsoft.vn/DefaultCollection/a5caa4a9-4c73-48d6-9b3c-d2764fe3e9ff/_workitems/edit/27441
# #     
# 
   @TEST_CASE_27441 @STATE_Design 
    Scenario Outline: Setting to be not log Timsheet in the days in the future
      # Shared step: Given user login ERP Timesheet - 27304
      Given user visit page "<url>"
      And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
      And user enter "<password>" into field by placeholder "Password"
      And user click on element "button[type='submit']"
      # ---
      # Shared step: When user visit Configuration page - 27435
      When user forced click on element ".bars"
      And user click on element "a span:contains('Admin')"
      And user click on anchor with link "app/configuration"
      And user forced click on element ".bars"
      Then user is navigated to page "app/configuration"
      Then element ".header" should be visible
      And it's text should contains 'Log timesheet for the future setting'
      # ---
      # Shared step: And user setting not to log timesheet in the future - 27439
      When user click on element ".container-fluid .card:eq(6) button:contains('Edit')"
      Then element "mat-checkbox:contains('User can log timesheet for the future')" should be not disabled
      When user uncheck element "mat-checkbox:contains('User can log timesheet for the future') input"
      And user click on element ".container-fluid .card:eq(6) button:contains('Save')"
      # ---
      # Shared step: Then user setting not to log timesheet successfully - 27548
      Then element "mat-checkbox:contains('User can log timesheet for the future') input" should be not checked
      # ---

      Examples: NewDataSet
      
      | url                              | username             | password |
      | http://uat.timesheet.nccsoft.vn/ | pmaccount2@gmail.com | 123qwe   |
  # ###########
#    Ref: https://ops.nccsoft.vn/DefaultCollection/a5caa4a9-4c73-48d6-9b3c-d2764fe3e9ff/_workitems/edit/27447
# #     
# 
   @TEST_CASE_27447 @STATE_Design 
    Scenario Outline: Verify user unable to log Timesheet in the future
      # Shared step: Given user login ERP Timesheet - 27304
      Given user visit page "<url>"
      And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
      And user enter "<password>" into field by placeholder "Password"
      And user click on element "button[type='submit']"
      # ---
      # Shared step: Then waiting for page loading - 27305
      Then waiting for page loading
      # ---
      # Shared step: When user visit My leave days page - 27306
      When user forced click on element ".bars"
      And user click on anchor with link "app/main/absence-day"
      And user forced click on element ".bars"
      Then user is navigated to page "app/main/absence-day"
      Then element ".header" should be visible
      And it's text should contains 'My off days'
      # ---
      # Shared step: And user able to get month year in the future - 27443
      And extract "mat-form-field:contains('Year') .mat-select-value-text span" text as alias "yearRequest"
      And user click on element "mat-form-field:contains('Month')"
      And user click on the next section of a element ".mat-selected"
      And extract "mat-form-field:contains('Month') .mat-select-value-text span" text as alias "monthRequest"
      # ---
      # Shared step: Then waiting for page loading - 27305
      Then waiting for page loading
      # ---
      # Shared step: And user can choose the day in the future - 27444
      When extract "mwl-calendar-month-cell:not(.cal-out-month):not(.today):not(:contains('Approved')):not(:contains('Off')):eq(1) .cal-day-number" text as alias "dayFuture"
      # ---
      # Shared step: When user visit My timesheets - 27314
      When user forced click on element ".bars"
      And user click on anchor with link "app/main/mytimesheets"
      And user forced click on element ".bars"
      Then user is navigated to page "app/main/mytimesheets"
      Then element "h2" should be visible
      And it's text should contains 'Tardiness Detail'
      # ---
      # Shared step: And user can choose day to log timesheet - 27315
      When user click on element "mat-datepicker-toggle"
      Then element "mat-calendar" should be visible
      And user click on element ".mat-calendar-period-button"
      And user click on element ".mat-calendar-body-cell-content" contains alias "@yearRequest"
      And user click on element ".mat-calendar-body tr td" is "@monthRequest" child by alias
      And user click on element ".mat-calendar-body-cell-content" contains exact alias "@dayNumber"
      # ---
      # Shared step: And user log timesheet on day in the future - 27445
      Then user forced click on element ".mat-tab-body-wrapper button.mat-flat-button:first"
      Then element ".mat-dialog-container" should be visible
      And it's text should contains "New Timesheet"
      And user click on element "[name=project]"
      And user click on element ".mat-select-panel .mat-option:first"
      And user enter "Lam task Frontend" into field by name "[name=note]"
      And user enter "9" into field by name "[name=workingTime]"
      And user click on element "[name=typeOfWorks]"
      And user click on element ".mat-select-panel .mat-option:contains('Overtime')"
      And user click on element has text "Save"
      # ---
      # Shared step: Then user log timesheet on day in the future failed - 27446
      And element ".toast-error:contains('for the future')" should be exist
      # ---

      Examples: NewDataSet
      
      | url                              | username             | password |
      | http://uat.timesheet.nccsoft.vn/ | pmaccount2@gmail.com | 123qwe   |
  # ###########
#    Ref: https://ops.nccsoft.vn/DefaultCollection/a5caa4a9-4c73-48d6-9b3c-d2764fe3e9ff/_workitems/edit/27449
# #     
# 
   @TEST_CASE_27449 @STATE_Design 
    Scenario Outline: Setting to able to log Timsheet in the days in the future
      # Shared step: Given user login ERP Timesheet - 27304
      Given user visit page "<url>"
      And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
      And user enter "<password>" into field by placeholder "Password"
      And user click on element "button[type='submit']"
      # ---
      # Shared step: When user visit Configuration page - 27435
      When user forced click on element ".bars"
      And user click on element "a span:contains('Admin')"
      And user click on anchor with link "app/configuration"
      And user forced click on element ".bars"
      Then user is navigated to page "app/configuration"
      Then element ".header" should be visible
      And it's text should contains 'Log timesheet for the future setting'
      # ---
      # Shared step: And user setting to log timesheet for the future - 27448
      When user click on element ".container-fluid .card:eq(6) button:contains('Edit')"
      Then element "mat-checkbox:contains('User can log timesheet for the future')" should be not disabled
      When user check element "mat-checkbox:contains('User can log timesheet for the future') input"
      And user clear element "input[name='dayAllow']"
      And user enter "1000" into field "input[name='dayAllow']"
      And user click on element ".container-fluid .card:eq(6) button:contains('Save')"
      # ---
      # Shared step: Then user setting to log timesheet in the future successfully - 27549
      Then element "mat-checkbox:contains('User can log timesheet for the future') input" should be checked
      # ---

      Examples: NewDataSet
      
      | url                              | username             | password |
      | http://uat.timesheet.nccsoft.vn/ | pmaccount2@gmail.com | 123qwe   |
  # ###########
#    Ref: https://ops.nccsoft.vn/DefaultCollection/a5caa4a9-4c73-48d6-9b3c-d2764fe3e9ff/_workitems/edit/27453
# #     
# 
   @TEST_CASE_27453 @STATE_Design 
    Scenario Outline: Verify user unable to log Timesheet in the future
      # Shared step: Given user login ERP Timesheet - 27304
      Given user visit page "<url>"
      And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
      And user enter "<password>" into field by placeholder "Password"
      And user click on element "button[type='submit']"
      # ---
      # Shared step: Then waiting for page loading - 27305
      Then waiting for page loading
      # ---
      # Shared step: When user visit My leave days page - 27306
      When user forced click on element ".bars"
      And user click on anchor with link "app/main/absence-day"
      And user forced click on element ".bars"
      Then user is navigated to page "app/main/absence-day"
      Then element ".header" should be visible
      And it's text should contains 'My off days'
      # ---
      # Shared step: And user able to get month year in the future - 27443
      And extract "mat-form-field:contains('Year') .mat-select-value-text span" text as alias "yearRequest"
      And user click on element "mat-form-field:contains('Month')"
      And user click on the next section of a element ".mat-selected"
      And extract "mat-form-field:contains('Month') .mat-select-value-text span" text as alias "monthRequest"
      # ---
      # Shared step: Then waiting for page loading - 27305
      Then waiting for page loading
      # ---
      # Shared step: And user can choose the day in the future - 27444
      When extract "mwl-calendar-month-cell:not(.cal-out-month):not(.today):not(:contains('Approved')):not(:contains('Off')):eq(1) .cal-day-number" text as alias "dayFuture"
      # ---
      # Shared step: When user visit My timesheets - 27314
      When user forced click on element ".bars"
      And user click on anchor with link "app/main/mytimesheets"
      And user forced click on element ".bars"
      Then user is navigated to page "app/main/mytimesheets"
      Then element "h2" should be visible
      And it's text should contains 'Tardiness Detail'
      # ---
      # Shared step: And user can choose day to log timesheet - 27315
      When user click on element "mat-datepicker-toggle"
      Then element "mat-calendar" should be visible
      And user click on element ".mat-calendar-period-button"
      And user click on element ".mat-calendar-body-cell-content" contains alias "@yearRequest"
      And user click on element ".mat-calendar-body tr td" is "@monthRequest" child by alias
      And user click on element ".mat-calendar-body-cell-content" contains exact alias "@dayNumber"
      # ---
      # Shared step: And user log timesheet on day in the future - 27445
      Then user forced click on element ".mat-tab-body-wrapper button.mat-flat-button:first"
      Then element ".mat-dialog-container" should be visible
      And it's text should contains "New Timesheet"
      And user click on element "[name=project]"
      And user click on element ".mat-select-panel .mat-option:first"
      And user enter "Lam task Frontend" into field by name "[name=note]"
      And user enter "9" into field by name "[name=workingTime]"
      And user click on element "[name=typeOfWorks]"
      And user click on element ".mat-select-panel .mat-option:contains('Overtime')"
      And user click on element has text "Save"
      # ---
      # Shared step: Then user log timesheet on day in the future successfully - 27452
      And element ".toast-error:contains('for the future')" should be not exist
      And element ".toast-success" should be exist
      # ---

      Examples: NewDataSet
      
      | url                              | username             | password |
      | http://uat.timesheet.nccsoft.vn/ | pmaccount2@gmail.com | 123qwe   |

  
