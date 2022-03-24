# 1. Nhân viên không off giờ nào > Check log timesheet với normal working time = 7/8/9h (check cả require field) ok
# 2. Nhân viên không off giờ nào > Check log timesheet với normal working = 8, OT time ok
# 3. Nhân viên off (giờ/morning/afternoon/all day) > Check log timesheet với normal working time = 8h hoặc bằng/nhỏ hơn giờ đi làm (8 - giờ đã log nghỉ)
# 4. Nhân viên off (giờ/morning/afternoon/all day) > Check log timesheet với normal working time bằng đúng giờ đi làm và OT
# 5. Check nhân viên log 2 timesheet (normal working) trong 1 ngày với tổng của 2 timesheet lớn hơn giờ làm việc tiêu chuẩn (8h) hoặc giờ làm việc thực tế sau khi log leave (8h - giờ đã log nghỉ) ok
# 6. Setting để nhân viên không log timesheet được trong tương lai > Check nhân viên log timesheet cho ngày trong tương lai (normal/OT)
# 7. Setting để nhân viên không log được timesheet cho ngày trong quá khứ (tuần trước) > Check nhân viên log timesheet cho ngày trong quá khứ (tuần trước tuần hiện tại)
# 8. Setting để nhân viên log được timesheet trong tương lai > Check nhân viên log timesheet cho ngày trong tương lai (normal/OT)
# 9. Setting để nhân viên log được timesheet cho ngày trong quá khứ > Check nhân viên log timesheet cho ngày trong quá khứ
@TEST_PROJECT_NCC-ERP @TEST_PLAN_26829 @TEST_SUITE_27342 @TEST_SUITE_TYPE_staticTestSuite 
Feature: Log Timesheet on off day
Ref: https://ops.nccsoft.vn/DefaultCollection/a5caa4a9-4c73-48d6-9b3c-d2764fe3e9ff/_workitems/edit/27342


  # ###########
#    Ref: https://ops.nccsoft.vn/DefaultCollection/a5caa4a9-4c73-48d6-9b3c-d2764fe3e9ff/_workitems/edit/27353
# #     
# 
   @TEST_CASE_27353 @STATE_Design 
    Scenario Outline: Verify user sent request off all day
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
      # Shared step: When user select day to log request off all day - 27346
      When set element "mwl-calendar-month-cell:not(:contains('Approved')):not(:contains('Rejected')):not('.cal-out-month'):not(.cal-past):not(.cal-weekend):first" as alias "dayRequest"
      And extract "mwl-calendar-month-cell:not(:contains('Approved')):not(:contains('Rejected')):not('.cal-out-month'):not(.cal-past):not(.cal-weekend):first .cal-day-number" text as alias "dayNumber"
      And user click on element by alias "@dayRequest"
      # ---
      # Shared step: And user send request leave - 27348
      And user click on element has text "Send leave request"
      Then element ".mat-dialog-container h1" should be visible
      And it's text should contains "Submit leave request"
      When user forced click on element has text "Absence Type"
      And user click on element ".mat-select-panel .mat-option:first-child"
      And user value "Test request leave day!" into input with label "Reason"
      Then user click on element has text "Save"
      # ---
      # Shared step: Then user send request successfully - 27351
      And user is able to see element by alias "@dayRequest"
      Then element by alias "@dayRequest" should contains "Approved"
      # ---

      Examples: NewDataSet
      
      | url                              | username         | password |
      | http://uat.timesheet.nccsoft.vn/ | test20@gmail.com | 123qwe   |
  # ###########
#    Ref: https://ops.nccsoft.vn/DefaultCollection/a5caa4a9-4c73-48d6-9b3c-d2764fe3e9ff/_workitems/edit/27373
# #     
# 
   @TEST_CASE_27373 @STATE_Design 
    Scenario Outline: Verify users unable to log Timesheet on the day they are off
      # Shared step: Given user login ERP Timesheet - 27304
      Given user visit page "<url>"
      And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
      And user enter "<password>" into field by placeholder "Password"
      And user click on element "button[type='submit']"
      # ---
      # Shared step: Then waiting for page loading - 27305
      Then waiting for page loading
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
      # Shared step: When user log timesheet on day they are leave with normal working = 8h - 27372
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
      
      | url                              | username         | password |
      | http://uat.timesheet.nccsoft.vn/ | test20@gmail.com | 123qwe   |
  # ###########
#    Ref: https://ops.nccsoft.vn/DefaultCollection/a5caa4a9-4c73-48d6-9b3c-d2764fe3e9ff/_workitems/edit/27376
# #     
# 
   @TEST_CASE_27376 @STATE_Design 
    Scenario Outline: Verify users able to log Timesheet on the day they are off with normal working time + OT
      # Shared step: Given user login ERP Timesheet - 27304
      Given user visit page "<url>"
      And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
      And user enter "<password>" into field by placeholder "Password"
      And user click on element "button[type='submit']"
      # ---
      # Shared step: Then waiting for page loading - 27312
      Then waiting for page loading
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
      
      | url                              | username         | password |
      | http://uat.timesheet.nccsoft.vn/ | test20@gmail.com | 123qwe   |
  # ###########
#    Ref: https://ops.nccsoft.vn/DefaultCollection/a5caa4a9-4c73-48d6-9b3c-d2764fe3e9ff/_workitems/edit/27380
# #     
# 
   @TEST_CASE_27380 @STATE_Design 
    Scenario Outline: Verify user send an hourly leave request
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
      # Shared step: And User able to get month year request - 26998
      And extract "mat-form-field:contains('Year') .mat-select-value-text span" text as alias "yearRequest"
      And extract "mat-form-field:contains('Month') .mat-select-value-text span" text as alias "monthRequest"
      # ---
      # Shared step: Then waiting for page loading - 27312
      Then waiting for page loading
      # ---
      # Shared step: When user select day to send request for hourly leave - 27377
      When set element "mwl-calendar-month-cell:not(.cal-weekend):not(.cal-past):not(.cal-out-month):not(:contains('Approved')):not(:contains('Rejected')):first" as alias "dayRequest"
      And extract "mwl-calendar-month-cell:not(.cal-weekend):not(.cal-past):not(.cal-out-month):not(:contains('Approved')):not(:contains('Rejected')):first .cal-day-number" text as alias "dayNumber"
      # ---
      # Shared step: And user enters the number of hours off - 27378
      And user click on element by alias "@dayRequest"
      And user click on element by alias "@dayRequest"
      And user click on element by alias "@dayRequest"
      And user click on element by alias "@dayRequest"
      Then element ".mat-dialog-container" should be visible
      And user enter "2.3" into field by name "[name=time]"
      Then user click on element has text "Save"
      # ---
      # Shared step: And user send request leave - 27348
      And user click on element has text "Send leave request"
      Then element ".mat-dialog-container h1" should be visible
      And it's text should contains "Submit leave request"
      When user forced click on element has text "Absence Type"
      And user click on element ".mat-select-panel .mat-option:first-child"
      And user value "Test request leave day!" into input with label "Reason"
      Then user click on element has text "Save"
      # ---
      # Shared step: Then user send request successfully - 27351
      And user is able to see element by alias "@dayRequest"
      Then element by alias "@dayRequest" should contains "Approved"
      # ---

      Examples: NewDataSet
      
      | url                              | username         | password |
      | http://uat.timesheet.nccsoft.vn/ | test20@gmail.com | 123qwe   |
  # ###########
#    Ref: https://ops.nccsoft.vn/DefaultCollection/a5caa4a9-4c73-48d6-9b3c-d2764fe3e9ff/_workitems/edit/27386
# #     
# 
   @TEST_CASE_27386 @STATE_Design 
    Scenario Outline: Verify users able to log Timesheet with actual working hour
      # Shared step: Given user login ERP Timesheet - 27304
      Given user visit page "<url>"
      And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
      And user enter "<password>" into field by placeholder "Password"
      And user click on element "button[type='submit']"
      # ---
      # Shared step: Then waiting for page loading - 26972
      Then waiting for page loading
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
      # Shared step: When user log timesheet with actual working hours - 27383
      Then user forced click on element ".mat-tab-body-wrapper button.mat-flat-button:first"
      Then element ".mat-dialog-container" should be visible
      And it's text should contains "New Timesheet"
      And user click on element "[name=project]"
      And user click on element ".mat-select-panel .mat-option:first"
      And user enter "Lam task Frontend" into field by name "[name=note]"
      And user enter "5.7" into field by name "[name=workingTime]"
      And user click on element has text "Save"
      # ---
      # Shared step: Then user log timesheet successfully - 27325
      And element ".toast-success" should be exist
      # ---

      Examples: NewDataSet
      
      | url                              | username         | password |
      | http://uat.timesheet.nccsoft.vn/ | test20@gmail.com | 123qwe   |
  # ###########
#    Ref: https://ops.nccsoft.vn/DefaultCollection/a5caa4a9-4c73-48d6-9b3c-d2764fe3e9ff/_workitems/edit/27492
# #     
# 
   @TEST_CASE_27492 @STATE_Design 
    Scenario Outline: Verify user send an hourly leave request
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
      # Shared step: When user select day to send request for hourly leave - 27377
      When set element "mwl-calendar-month-cell:not(.cal-weekend):not(.cal-past):not(.cal-out-month):not(:contains('Approved')):not(:contains('Rejected')):first" as alias "dayRequest"
      And extract "mwl-calendar-month-cell:not(.cal-weekend):not(.cal-past):not(.cal-out-month):not(:contains('Approved')):not(:contains('Rejected')):first .cal-day-number" text as alias "dayNumber"
      # ---
      # Shared step: And user enters the number of hours off - 27378
      And user click on element by alias "@dayRequest"
      And user click on element by alias "@dayRequest"
      And user click on element by alias "@dayRequest"
      And user click on element by alias "@dayRequest"
      Then element ".mat-dialog-container" should be visible
      And user enter "2.3" into field by name "[name=time]"
      Then user click on element has text "Save"
      # ---
      # Shared step: And user send request leave - 27348
      And user click on element has text "Send leave request"
      Then element ".mat-dialog-container h1" should be visible
      And it's text should contains "Submit leave request"
      When user forced click on element has text "Absence Type"
      And user click on element ".mat-select-panel .mat-option:first-child"
      And user value "Test request leave day!" into input with label "Reason"
      Then user click on element has text "Save"
      # ---
      # Shared step: Then user send request successfully - 27351
      And user is able to see element by alias "@dayRequest"
      Then element by alias "@dayRequest" should contains "Approved"
      # ---

      Examples: NewDataSet
      
      | url                              | username         | password |
      | http://uat.timesheet.nccsoft.vn/ | test20@gmail.com | 123qwe   |
  # ###########
#    Ref: https://ops.nccsoft.vn/DefaultCollection/a5caa4a9-4c73-48d6-9b3c-d2764fe3e9ff/_workitems/edit/27391
# #     
# 
   @TEST_CASE_27391 @STATE_Design 
    Scenario Outline: Verify users able to log Timesheet with actual working hour+ OT
      # Shared step: Given user login ERP Timesheet - 27304
      Given user visit page "<url>"
      And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
      And user enter "<password>" into field by placeholder "Password"
      And user click on element "button[type='submit']"
      # ---
      # Shared step: Then waiting for page loading - 27305
      Then waiting for page loading
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
      # Shared step: When user log timesheet with actual working hour+ OT - 27390
      Then user forced click on element ".mat-tab-body-wrapper button.mat-flat-button:first"
      Then element ".mat-dialog-container" should be visible
      And it's text should contains "New Timesheet"
      And user click on element "[name=project]"
      And user click on element ".mat-select-panel .mat-option:first"
      And user enter "Lam task Frontend" into field by name "[name=note]"
      And user enter "5.7" into field by name "[name=workingTime]"
      And user click on element "[name=typeOfWorks]"
      And user click on element ".mat-select-panel .mat-option:contains('Overtime')"
      And user click on element has text "Save"
      # ---
      # Shared step: Then user log timesheet successfully - 27325
      And element ".toast-success" should be exist
      # ---

      Examples: NewDataSet
      
      | url                              | username         | password |
      | http://uat.timesheet.nccsoft.vn/ | test20@gmail.com | 123qwe   |
  # ###########
#    Ref: https://ops.nccsoft.vn/DefaultCollection/a5caa4a9-4c73-48d6-9b3c-d2764fe3e9ff/_workitems/edit/27395
# #     
# 
   @TEST_CASE_27395 @STATE_Design 
    Scenario Outline: Verify user sent request off morning
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
      # Shared step: And User able to get month year request - 26998
      And extract "mat-form-field:contains('Year') .mat-select-value-text span" text as alias "yearRequest"
      And extract "mat-form-field:contains('Month') .mat-select-value-text span" text as alias "monthRequest"
      # ---
      # Shared step: Then waiting for page loading - 27305
      Then waiting for page loading
      # ---
      # Shared step: And user select day to send request off morning - 27393
      When set element "mwl-calendar-month-cell:not(.cal-weekend):not(.cal-past):not(.cal-out-month):not(:contains('Approved')):not(:contains('Rejected')):first" as alias "dayRequest"
      And extract "mwl-calendar-month-cell:not(.cal-weekend):not(.cal-past):not(.cal-out-month):not(:contains('Approved')):not(:contains('Rejected')):first .cal-day-number" text as alias "dayNumber"
      And user click on element by alias "@dayRequest"
      And user click on element by alias "@dayRequest"
      # ---
      # Shared step: And user send request leave - 27348
      And user click on element has text "Send leave request"
      Then element ".mat-dialog-container h1" should be visible
      And it's text should contains "Submit leave request"
      When user forced click on element has text "Absence Type"
      And user click on element ".mat-select-panel .mat-option:first-child"
      And user value "Test request leave day!" into input with label "Reason"
      Then user click on element has text "Save"
      # ---
      # Shared step: Then user send request successfully - 27351
      And user is able to see element by alias "@dayRequest"
      Then element by alias "@dayRequest" should contains "Approved"
      # ---

      Examples: NewDataSet
      
      | url                              | username         | password |
      | http://uat.timesheet.nccsoft.vn/ | test20@gmail.com | 123qwe   |
  # ###########
#    Ref: https://ops.nccsoft.vn/DefaultCollection/a5caa4a9-4c73-48d6-9b3c-d2764fe3e9ff/_workitems/edit/27400
# #     
# 
   @TEST_CASE_27400 @STATE_Design 
    Scenario Outline: Verify users unable to log Timesheet on the day they are off morning with working hour = 4.5
      # Shared step: Given user login ERP Timesheet - 27304
      Given user visit page "<url>"
      And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
      And user enter "<password>" into field by placeholder "Password"
      And user click on element "button[type='submit']"
      # ---
      # Shared step: Then waiting for page loading - 27305
      Then waiting for page loading
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
      # Shared step: When user can log timesheet on day off morning - 27399
      Then user forced click on element ".mat-tab-body-wrapper button.mat-flat-button:first"
      Then element ".mat-dialog-container" should be visible
      And it's text should contains "New Timesheet"
      And user click on element "[name=project]"
      And user click on element ".mat-select-panel .mat-option:first"
      And user enter "Lam task Frontend" into field by name "[name=note]"
      And user enter "4.5" into field by name "[name=workingTime]"
      And user click on element has text "Save"
      # ---
      # Shared step: Then user log timesheet successfully - 27325
      And element ".toast-success" should be exist
      # ---

      Examples: NewDataSet
      
      | url                              | username         | password |
      | http://uat.timesheet.nccsoft.vn/ | test20@gmail.com | 123qwe   |
  # ###########
#    Ref: https://ops.nccsoft.vn/DefaultCollection/a5caa4a9-4c73-48d6-9b3c-d2764fe3e9ff/_workitems/edit/27496
# #     
# 
   @TEST_CASE_27496 @STATE_Design 
    Scenario Outline: Verify user sent request off morning
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
      # Shared step: And user select day to send request off morning - 27393
      When set element "mwl-calendar-month-cell:not(.cal-weekend):not(.cal-past):not(.cal-out-month):not(:contains('Approved')):not(:contains('Rejected')):first" as alias "dayRequest"
      And extract "mwl-calendar-month-cell:not(.cal-weekend):not(.cal-past):not(.cal-out-month):not(:contains('Approved')):not(:contains('Rejected')):first .cal-day-number" text as alias "dayNumber"
      And user click on element by alias "@dayRequest"
      And user click on element by alias "@dayRequest"
      # ---
      # Shared step: And user send request leave - 27348
      And user click on element has text "Send leave request"
      Then element ".mat-dialog-container h1" should be visible
      And it's text should contains "Submit leave request"
      When user forced click on element has text "Absence Type"
      And user click on element ".mat-select-panel .mat-option:first-child"
      And user value "Test request leave day!" into input with label "Reason"
      Then user click on element has text "Save"
      # ---
      # Shared step: Then user send request successfully - 27351
      And user is able to see element by alias "@dayRequest"
      Then element by alias "@dayRequest" should contains "Approved"
      # ---

      Examples: NewDataSet
      
      | url                              | username         | password |
      | http://uat.timesheet.nccsoft.vn/ | test20@gmail.com | 123qwe   |
  # ###########
#    Ref: https://ops.nccsoft.vn/DefaultCollection/a5caa4a9-4c73-48d6-9b3c-d2764fe3e9ff/_workitems/edit/27407
# #     
# 
   @TEST_CASE_27407 @STATE_Design 
    Scenario Outline: Verify users able to log Timesheet on the day they are off morning with working hour = 4.5 + OT
      # Shared step: Given user login ERP Timesheet - 27304
      Given user visit page "<url>"
      And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
      And user enter "<password>" into field by placeholder "Password"
      And user click on element "button[type='submit']"
      # ---
      # Shared step: Then waiting for page loading - 27312
      Then waiting for page loading
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
      # Shared step: When user log timesheet with normal working time = 4.5 + OT - 27405
      Then user forced click on element ".mat-tab-body-wrapper button.mat-flat-button:first"
      Then element ".mat-dialog-container" should be visible
      And it's text should contains "New Timesheet"
      And user click on element "[name=project]"
      And user click on element ".mat-select-panel .mat-option:first"
      And user enter "Lam task Frontend" into field by name "[name=note]"
      And user enter "4.5" into field by name "[name=workingTime]"
      And user click on element "[name=typeOfWorks]"
      And user click on element ".mat-select-panel .mat-option:contains('Overtime')"
      And user click on element has text "Save"
      # ---
      # Shared step: Then user log timesheet successfully - 27325
      And element ".toast-success" should be exist
      # ---

      Examples: NewDataSet
      
      | url                              | username         | password |
      | http://uat.timesheet.nccsoft.vn/ | test20@gmail.com | 123qwe   |
  # ###########
#    Ref: https://ops.nccsoft.vn/DefaultCollection/a5caa4a9-4c73-48d6-9b3c-d2764fe3e9ff/_workitems/edit/27412
# #     
# 
   @TEST_CASE_27412 @STATE_Design 
    Scenario Outline: Verify user sent request off afternoon
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
      # Shared step: When user select day to send request off afternoon - 27416
      When set element "mwl-calendar-month-cell:not(.cal-weekend):not(.cal-past):not(.cal-out-month):not(:contains('Approved')):not(:contains('Rejected')):first" as alias "dayRequest"
      And extract "mwl-calendar-month-cell:not(.cal-weekend):not(.cal-past):not(.cal-out-month):not(:contains('Approved')):not(:contains('Rejected')):first .cal-day-number" text as alias "dayNumber"
      # ---
      # Shared step: And user select off afternoon - 27418
      And user click on element by alias "@dayRequest"
      And user click on element by alias "@dayRequest"
      And user click on element by alias "@dayRequest"
      # ---
      # Shared step: And user send request leave - 27348
      And user click on element has text "Send leave request"
      Then element ".mat-dialog-container h1" should be visible
      And it's text should contains "Submit leave request"
      When user forced click on element has text "Absence Type"
      And user click on element ".mat-select-panel .mat-option:first-child"
      And user value "Test request leave day!" into input with label "Reason"
      Then user click on element has text "Save"
      # ---
      # Shared step: Then user send request successfully - 27351
      And user is able to see element by alias "@dayRequest"
      Then element by alias "@dayRequest" should contains "Approved"
      # ---

      Examples: NewDataSet
      
      | url                              | username         | password |
      | http://uat.timesheet.nccsoft.vn/ | test20@gmail.com | 123qwe   |
  # ###########
#    Ref: https://ops.nccsoft.vn/DefaultCollection/a5caa4a9-4c73-48d6-9b3c-d2764fe3e9ff/_workitems/edit/27422
# #     
# 
   @TEST_CASE_27422 @STATE_Design 
    Scenario Outline: Verify usersable to log Timesheet on the day they are off afternoon with working hour = 3.5
      # Shared step: Given user login ERP Timesheet - 27304
      Given user visit page "<url>"
      And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
      And user enter "<password>" into field by placeholder "Password"
      And user click on element "button[type='submit']"
      # ---
      # Shared step: Then waiting for page loading - 27305
      Then waiting for page loading
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
      # Shared step: When user log timesheet on day they are off afternoon - 27420
      Then user forced click on element ".mat-tab-body-wrapper button.mat-flat-button:first"
      Then element ".mat-dialog-container" should be visible
      And it's text should contains "New Timesheet"
      And user click on element "[name=project]"
      And user click on element ".mat-select-panel .mat-option:first"
      And user enter "Lam task Frontend" into field by name "[name=note]"
      And user enter "3.5" into field by name "[name=workingTime]"
      And user click on element has text "Save"
      # ---
      # Shared step: Then user log timesheet successfully - 27325
      And element ".toast-success" should be exist
      # ---

      Examples: NewDataSet
      
      | url                              | username         | password |
      | http://uat.timesheet.nccsoft.vn/ | test20@gmail.com | 123qwe   |
  # ###########
#    Ref: https://ops.nccsoft.vn/DefaultCollection/a5caa4a9-4c73-48d6-9b3c-d2764fe3e9ff/_workitems/edit/27499
# #     
# 
   @TEST_CASE_27499 @STATE_Design 
    Scenario Outline: Verify user sent request off afternoon
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
      # Shared step: When user select day to send request off afternoon - 27416
      When set element "mwl-calendar-month-cell:not(.cal-weekend):not(.cal-past):not(.cal-out-month):not(:contains('Approved')):not(:contains('Rejected')):first" as alias "dayRequest"
      And extract "mwl-calendar-month-cell:not(.cal-weekend):not(.cal-past):not(.cal-out-month):not(:contains('Approved')):not(:contains('Rejected')):first .cal-day-number" text as alias "dayNumber"
      # ---
      # Shared step: And user select off afternoon - 27418
      And user click on element by alias "@dayRequest"
      And user click on element by alias "@dayRequest"
      And user click on element by alias "@dayRequest"
      # ---
      # Shared step: And user send request leave - 27348
      And user click on element has text "Send leave request"
      Then element ".mat-dialog-container h1" should be visible
      And it's text should contains "Submit leave request"
      When user forced click on element has text "Absence Type"
      And user click on element ".mat-select-panel .mat-option:first-child"
      And user value "Test request leave day!" into input with label "Reason"
      Then user click on element has text "Save"
      # ---
      # Shared step: Then user send request successfully - 27351
      And user is able to see element by alias "@dayRequest"
      Then element by alias "@dayRequest" should contains "Approved"
      # ---

      Examples: NewDataSet
      
      | url                              | username         | password |
      | http://uat.timesheet.nccsoft.vn/ | test20@gmail.com | 123qwe   |
  # ###########
#    Ref: https://ops.nccsoft.vn/DefaultCollection/a5caa4a9-4c73-48d6-9b3c-d2764fe3e9ff/_workitems/edit/27426
# #     
# 
   @TEST_CASE_27426 @STATE_Design 
    Scenario Outline: Verify users able to log Timesheet on the day they are off afternoon with working hour = 3.5 + OT
      # Shared step: Given user login ERP Timesheet - 27304
      Given user visit page "<url>"
      And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
      And user enter "<password>" into field by placeholder "Password"
      And user click on element "button[type='submit']"
      # ---
      # Shared step: Then waiting for page loading - 27305
      Then waiting for page loading
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
      # Shared step: When user log timesheet with normal working time = 3.5 +OT - 27424
      Then user forced click on element ".mat-tab-body-wrapper button.mat-flat-button:first"
      Then element ".mat-dialog-container" should be visible
      And it's text should contains "New Timesheet"
      And user click on element "[name=project]"
      And user click on element ".mat-select-panel .mat-option:first"
      And user enter "Lam task Frontend" into field by name "[name=note]"
      And user enter "3.5" into field by name "[name=workingTime]"
      And user click on element "[name=typeOfWorks]"
      And user click on element ".mat-select-panel .mat-option:contains('Overtime')"
      And user click on element has text "Save"
      # ---
      # Shared step: Then user log timesheet successfully - 27325
      And element ".toast-success" should be exist
      # ---
      

      Examples: NewDataSet
      
      | url                              | username         | password |
      | http://uat.timesheet.nccsoft.vn/ | test20@gmail.com | 123qwe   |

  
