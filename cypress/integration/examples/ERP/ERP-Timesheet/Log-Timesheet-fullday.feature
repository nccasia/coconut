@TEST_PROJECT_NCC-ERP @TEST_PLAN_26829 @TEST_SUITE_27300 @TEST_SUITE_TYPE_staticTestSuite 
Feature: Log Timesheet on normal day
Ref: https://ops.nccsoft.vn/DefaultCollection/a5caa4a9-4c73-48d6-9b3c-d2764fe3e9ff/_workitems/edit/27300


  # ###########
#    Ref: https://ops.nccsoft.vn/DefaultCollection/a5caa4a9-4c73-48d6-9b3c-d2764fe3e9ff/_workitems/edit/27330
# #     
# 
   @TEST_CASE_27330 @STATE_Design 
    Scenario Outline: Verify user who work all day unable to log Timesheet with normal working time > 8h
      # Shared step: Given user login ERP Timesheet - 27304
      Given user visit page "<url>"
      And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
      And user enter "<password>" into field by placeholder "Password"
      And user click on element "button[type='submit']"
      # ---
      # Shared step: Then waiting for page loading - 27312
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
      # Shared step: And user able to get month year request - 27307
      And extract "mat-form-field:contains('Year') .mat-select-value-text span" text as alias "yearRequest"
      And extract "mat-form-field:contains('Month') .mat-select-value-text span" text as alias "monthRequest"
      # ---
      # Shared step: And users can choose normal days - 27313
      When extract "mwl-calendar-month-cell:not(.cal-past):not(.cal-out-month ):not(.cal-weekend):not(:contains('Off')):first .cal-day-number" text as alias "fullTimeDay"
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
      # Shared step: When user log timesheet with normal working time > 8h - 27329
      Then user forced click on element ".mat-tab-body-wrapper button.mat-flat-button:first"
      Then element ".mat-dialog-container" should be visible
      And it's text should contains "New Timesheet"
      And user click on element "[name=project]"
      And user click on element ".mat-select-panel .mat-option:first"
      And user enter "Lam task Frontend" into field by name "[name=note]"
      And user enter "9" into field by name "[name=workingTime]"
      And user click on element has text "Save"
      # ---
      # Shared step: Then user logs timesheet failed - 27326
      And element ".toast-error" should be exist
      # ---

      Examples: NewDataSet
      
      | url                              | username           | password |
      | http://uat.timesheet.nccsoft.vn/ | trang.dangthihuyen | 123qwe   |
  # ###########
#    Ref: https://ops.nccsoft.vn/DefaultCollection/a5caa4a9-4c73-48d6-9b3c-d2764fe3e9ff/_workitems/edit/27320
# #     
# 
   @TEST_CASE_27320 @STATE_Design 
    Scenario Outline: Verify user who work all day can log Timesheet with normal working time <= 8h
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
      # Shared step: And user able to get month year request - 27307
      And extract "mat-form-field:contains('Year') .mat-select-value-text span" text as alias "yearRequest"
      And extract "mat-form-field:contains('Month') .mat-select-value-text span" text as alias "monthRequest"
      # ---
      # Shared step: Then waiting for page loading - 27312
      Then waiting for page loading
      # ---
      # Shared step: And users can choose normal days - 27313
      When extract "mwl-calendar-month-cell:not(.cal-past):not(.cal-out-month ):not(.cal-weekend):not(:contains('Off')):first .cal-day-number" text as alias "fullTimeDay"
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
      # Shared step: When user log timesheet with normal working <= 8 - 27316
      Then user forced click on element ".mat-tab-body-wrapper button.mat-flat-button:first"
      Then element ".mat-dialog-container" should be visible
      And it's text should contains "New Timesheet"
      And user click on element "[name=project]"
      And user click on element ".mat-select-panel .mat-option:first"
      And user enter "Lam task Frontend" into field by name "[name=note]"
      And user enter "8" into field by name "[name=workingTime]"
      And user click on element has text "Save"
      # ---
      # Shared step: Then user log timesheet successfully - 27325
      And element ".toast-success" should be exist
      # ---

      Examples: NewDataSet
      
      | url                              | username           | password |
      | http://uat.timesheet.nccsoft.vn/ | trang.dangthihuyen | 123qwe   |
  # ###########
#    Ref: https://ops.nccsoft.vn/DefaultCollection/a5caa4a9-4c73-48d6-9b3c-d2764fe3e9ff/_workitems/edit/27323
# #     
# 
   @TEST_CASE_27323 @STATE_Design 
    Scenario Outline: Verify users unable to log 2 Timesheet on the day with total working hours > actual working hours
      # Shared step: Given user login ERP Timesheet - 27304
      Given user visit page "<url>"
      And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
      And user enter "<password>" into field by placeholder "Password"
      And user click on element "button[type='submit']"
      # ---
      # Shared step: When user visit My timesheets - 27314
      When user forced click on element ".bars"
      And user click on anchor with link "app/main/mytimesheets"
      And user forced click on element ".bars"
      Then user is navigated to page "app/main/mytimesheets"
      Then element "h2" should be visible
      And it's text should contains 'Tardiness Detail'
      # ---
      # Shared step: And user able to choose the date to be logged - 27321
      When user click on element ".mat-tab-label-content:contains('0'):first"
      And element "mat-tab-body table tr" should be exist
      # ---
      # Shared step: When user log timesheet with normal working <= 8 - 27316
      Then user forced click on element ".mat-tab-body-wrapper button.mat-flat-button:first"
      Then element ".mat-dialog-container" should be visible
      And it's text should contains "New Timesheet"
      And user click on element "[name=project]"
      And user click on element ".mat-select-panel .mat-option:first"
      And user enter "Lam task Frontend" into field by name "[name=note]"
      And user enter "8" into field by name "[name=workingTime]"
      And user click on element has text "Save"
      # ---
      # Shared step: Then user logs timesheet failed - 27326
      And element ".toast-error" should be exist
      # ---

      Examples: NewDataSet
      
      | url                              | username           | password |
      | http://uat.timesheet.nccsoft.vn/ | trang.dangthihuyen | 123qwe   |
  # ###########
#    Ref: https://ops.nccsoft.vn/DefaultCollection/a5caa4a9-4c73-48d6-9b3c-d2764fe3e9ff/_workitems/edit/27341
# #     
# 
   @TEST_CASE_27341 @STATE_Design 
    Scenario Outline: Verify user who work all day can log Timesheet with normal working time = 8h + OT
      # Shared step: Given user login ERP Timesheet - 27304
      Given user visit page "<url>"
      And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
      And user enter "<password>" into field by placeholder "Password"
      And user click on element "button[type='submit']"
      # ---
      # Shared step: Then waiting for page loading - 26988
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
      # Shared step: And user able to get month year request - 27307
      And extract "mat-form-field:contains('Year') .mat-select-value-text span" text as alias "yearRequest"
      And extract "mat-form-field:contains('Month') .mat-select-value-text span" text as alias "monthRequest"
      # ---
      # Shared step: And users can choose normal days - 27313
      When extract "mwl-calendar-month-cell:not(.cal-past):not(.cal-out-month ):not(.cal-weekend):not(:contains('Off')):first .cal-day-number" text as alias "fullTimeDay"
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
      # Shared step: When user log timesheet with normal working time = 8h + OT - 27339
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
      # Shared step: Then user log timesheet successfully - 27325
      And element ".toast-success" should be exist
      # ---

      Examples: NewDataSet
      
      | url                              | username           | password |
      | http://uat.timesheet.nccsoft.vn/ | trang.dangthihuyen | 123qwe   |

  
