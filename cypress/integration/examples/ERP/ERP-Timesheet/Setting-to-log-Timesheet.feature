# 1. Nhân viên không off giờ nào > Check log timesheet với normal working time = 7/8/9h (check cả require field) ok
# 2. Nhân viên không off giờ nào > Check log timesheet với normal working = 8, OT time ok
# 3. Nhân viên off (giờ/morning/afternoon/all day) > Check log timesheet với normal working time = 8h hoặc bằng/nhỏ hơn giờ đi làm (8 - giờ đã log nghỉ)
# 4. Nhân viên off (giờ/morning/afternoon/all day) > Check log timesheet với normal working time bằng đúng giờ đi làm và OT
# 5. Check nhân viên log 2 timesheet (normal working) trong 1 ngày với tổng của 2 timesheet lớn hơn giờ làm việc tiêu chuẩn (8h) hoặc giờ làm việc thực tế sau khi log leave (8h - giờ đã log nghỉ) ok
# 6. Setting để nhân viên không log timesheet được trong tương lai > Check nhân viên log timesheet cho ngày trong tương lai (normal/OT)
# 7. Setting để nhân viên không log được timesheet cho ngày trong quá khứ (tuần trước) > Check nhân viên log timesheet cho ngày trong quá khứ (tuần trước tuần hiện tại)
# 8. Setting để nhân viên log được timesheet trong tương lai > Check nhân viên log timesheet cho ngày trong tương lai (normal/OT)
# 9. Setting để nhân viên log được timesheet cho ngày trong quá khứ > Check nhân viên log timesheet cho ngày trong quá khứ
@TEST_SETTING_TO_LOG_TIMESHEET
Feature: User setting to log timesheet
    @TEST_CASE_1
    Scenario Outline: Setting to be not log Timsheet in the days in the future
        # Shared step: Given user login ERP Timesheet
        Given user visit page "<url>"
        And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
        And user enter "<password>" into field by placeholder "Password"
        And user click on element "button[type='submit']"
        #Shared step: Then user able to get user-info

        #Shared step : When user visit My leave days page
        When user forced click on element ".bars"
        And user click on element "a span:contains('Admin')"
        And user click on anchor with link "app/configuration"
        And user forced click on element ".bars"
        Then user is navigated to page "app/configuration"
        Then element ".header" should be visible
        And it's text should contains 'Log timesheet for the future setting'

        #Shared step: And user setting to log timesheet for the future
        When user click on element ".container-fluid .card:eq(6) button:contains('Edit')"
        Then element "mat-checkbox:contains('User can log timesheet for the future')" should be not disabled
        When user uncheck element "mat-checkbox:contains('User can log timesheet for the future') input"
        And user click on element ".container-fluid .card:eq(6) button:contains('Save')"
    Examples: NewDataSet
            | url | username | password |
            |  http://uat.timesheet.nccsoft.vn/ | admin  | 123qwe  |

       @TEST_CASE_1
    Scenario Outline: Verify user unable to log Timesheet in the future
     # Shared step: Given user login ERP Timesheet
        Given user visit page "<url>"
        And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
        And user enter "<password>" into field by placeholder "Password"
        And user click on element "button[type='submit']"
        #Shared step: Then waiting for page loading
        Then waiting for page loading


        #Shared step : When user visit My leave days
        When user forced click on element ".bars"
        And user click on anchor with link "app/main/absence-day"
        And user forced click on element ".bars"
        Then user is navigated to page "app/main/absence-day"
        Then element ".header" should be visible
        And it's text should contains 'My off days'

        #Shared step: And User able to get month year request
        And extract "mat-form-field:contains('Year') .mat-select-value-text span" text as alias "yearRequest"
        And user click on element "mat-form-field:contains('Month')"
        And user click on the next section of a element ".mat-selected"
               And extract "mat-form-field:contains('Month') .mat-select-value-text span" text as alias "monthRequest"

        #Shared step: Then waiting for page loading
        Then waiting for page loading
        #Shared step:And Users can choose the day on which they work all day
        When extract "mwl-calendar-month-cell:not(.cal-out-month):not(.today):not(:contains('Approved')):not(:contains('Off')):eq(1) .cal-day-number" text as alias "dayFuture"

        #Shared step : When user visit My timesheets
        When user forced click on element ".bars"
        And user click on anchor with link "app/main/mytimesheets"
        And user forced click on element ".bars"
        Then user is navigated to page "app/main/mytimesheets"
        Then element "h2" should be visible
        And it's text should contains 'Tardiness Detail'

        #Shared step : And user can choose day to log timesheet
        When user click on element "mat-datepicker-toggle"
        Then element "mat-calendar" should be visible
        And user click on element ".mat-calendar-period-button"
        And user click on element ".mat-calendar-body-cell-content" contains alias "@yearRequest"
        And user click on element ".mat-calendar-body tr td" is "@monthRequest" child by alias
        And user click on element ".mat-calendar-body-cell-content" contains exact alias "@dayFuture"

        #Shared step : When user log timesheet 
        Then user forced click on element ".mat-tab-body-wrapper button.mat-flat-button:first"
        Then element ".mat-dialog-container" should be visible
        And it's text should contains "New Timesheet"
        And  user click on element "[name=project]"
        And  user click on element ".mat-select-panel .mat-option:first"
        And  user enter "Lam task Frontend" into field by name "[name=note]"
        And  user enter "9" into field by name "[name=workingTime]"
        And  user click on element "[name=typeOfWorks]"
        And  user click on element ".mat-select-panel .mat-option:contains('Overtime')"
        And user click on element has text "Save"
        And element ".toast-error:contains('for the future')" should be exist

        

        Examples: NewDataSet
            | url | username | password |
            |  http://uat.timesheet.nccsoft.vn/ | admin  | 123qwe  |
    

    @TEST_CASE_1
    Scenario Outline: Setting to able to log Timsheet in the days in the future
        # Shared step: Given user login ERP Timesheet
        Given user visit page "<url>"
        And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
        And user enter "<password>" into field by placeholder "Password"
        And user click on element "button[type='submit']"
        #Shared step: Then user able to get user-info

        #Shared step : When user visit My leave days page
        When user forced click on element ".bars"
        And user click on element "a span:contains('Admin')"
        And user click on anchor with link "app/configuration"
        And user forced click on element ".bars"
        Then user is navigated to page "app/configuration"
        Then element ".header" should be visible
        And it's text should contains 'Log timesheet for the future setting'

        #Shared step: And user setting to log timesheet for the future
        When user click on element ".container-fluid .card:eq(6) button:contains('Edit')"
        Then element "mat-checkbox:contains('User can log timesheet for the future')" should be not disabled
        When user check element "mat-checkbox:contains('User can log timesheet for the future') input"
        And user clear element "input[name='dayAllow']"
        And user enter "1000" into field "input[name='dayAllow']"
        And user click on element ".container-fluid .card:eq(6) button:contains('Save')"
    Examples: NewDataSet
            | url | username | password |
            |  http://uat.timesheet.nccsoft.vn/ | pmaccount2@gmail.com  | 123qwe  |

       @TEST_CASE_1
    Scenario Outline: Verify user unable to log Timesheet in the future
     # Shared step: Given user login ERP Timesheet
        Given user visit page "<url>"
        And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
        And user enter "<password>" into field by placeholder "Password"
        And user click on element "button[type='submit']"
        #Shared step: Then waiting for page loading
        Then waiting for page loading


        #Shared step : When user visit My leave days
        When user forced click on element ".bars"
        And user click on anchor with link "app/main/absence-day"
        And user forced click on element ".bars"
        Then user is navigated to page "app/main/absence-day"
        Then element ".header" should be visible
        And it's text should contains 'My off days'

        #Shared step: And User able to get month year request
        And extract "mat-form-field:contains('Year') .mat-select-value-text span" text as alias "yearRequest"
        And user click on element "mat-form-field:contains('Month')"
        And user click on the next section of a element ".mat-selected"
               And extract "mat-form-field:contains('Month') .mat-select-value-text span" text as alias "monthRequest"

        #Shared step: Then waiting for page loading
        Then waiting for page loading
        #Shared step:And Users can choose the day on which they work all day
        When extract "mwl-calendar-month-cell:not(.cal-out-month):not(.today):not(:contains('Approved')):not(:contains('Off')):eq(1) .cal-day-number" text as alias "dayFuture"

        #Shared step : When user visit My timesheets
        When user forced click on element ".bars"
        And user click on anchor with link "app/main/mytimesheets"
        And user forced click on element ".bars"
        Then user is navigated to page "app/main/mytimesheets"
        Then element "h2" should be visible
        And it's text should contains 'Tardiness Detail'

        #Shared step : And user can choose day to log timesheet
        When user click on element "mat-datepicker-toggle"
        Then element "mat-calendar" should be visible
        And user click on element ".mat-calendar-period-button"
        And user click on element ".mat-calendar-body-cell-content" contains alias "@yearRequest"
        And user click on element ".mat-calendar-body tr td" is "@monthRequest" child by alias
        And user click on element ".mat-calendar-body-cell-content" contains exact alias "@dayFuture"

        #Shared step : When user log timesheet 
        Then user forced click on element ".mat-tab-body-wrapper button.mat-flat-button:first"
        Then element ".mat-dialog-container" should be visible
        And it's text should contains "New Timesheet"
        And  user click on element "[name=project]"
        And  user click on element ".mat-select-panel .mat-option:first"
        And  user enter "Lam task Frontend" into field by name "[name=note]"
        And  user enter "9" into field by name "[name=workingTime]"
        And  user click on element "[name=typeOfWorks]"
        And  user click on element ".mat-select-panel .mat-option:contains('Overtime')"
        And user click on element has text "Save"
        And element ".toast-error:contains('for the future')" should be not exist
        And element ".toast-success" should be exist

        

        Examples: NewDataSet
            | url | username | password |
            |  http://uat.timesheet.nccsoft.vn/ | pmaccount2@gmail.com  | 123qwe  |
    