# 1. Nhân viên không off giờ nào > Check log timesheet với normal working time = 7/8/9h (check cả require field)
# 2. Nhân viên không off giờ nào > Check log timesheet với normal working = 8, OT time
# 3. Nhân viên off (giờ/morning/afternoon/all day) > Check log timesheet với normal working time = 8h hoặc bằng/nhỏ hơn giờ đi làm (8 - giờ đã log nghỉ)
# 4. Nhân viên off (giờ/morning/afternoon/all day) > Check log timesheet với normal working time bằng đúng giờ đi làm và OT
# 5. Check nhân viên log 2 timesheet (normal working) trong 1 ngày với tổng của 2 timesheet lớn hơn giờ làm việc tiêu chuẩn (8h) hoặc giờ làm việc thực tế sau khi log leave (8h - giờ đã log nghỉ)
# 6. Setting để nhân viên không log timesheet được trong tương lai > Check nhân viên log timesheet cho ngày trong tương lai (normal/OT)
# 7. Setting để nhân viên không log được timesheet cho ngày trong quá khứ (tuần trước) > Check nhân viên log timesheet cho ngày trong quá khứ (tuần trước tuần hiện tại)
# 8. Setting để nhân viên log được timesheet trong tương lai > Check nhân viên log timesheet cho ngày trong tương lai (normal/OT)
# 9. Setting để nhân viên log được timesheet cho ngày trong quá khứ > Check nhân viên log timesheet cho ngày trong quá khứ
@TEST_LOG_TIMESHEET
Feature: User can log Timesheet on day work all day 
    @TEST_CASE_1
    Scenario Outline: Verify user who work all day can log Timesheet with normal working time <= 8h etc
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
        And extract "mat-form-field:contains('Month') .mat-select-value-text span" text as alias "monthRequest"

        #Shared step: Then waiting for page loading
        Then waiting for page loading

        #Shared step:And Users can choose the day on which they work all day
        When extract "mwl-calendar-month-cell:not(.cal-past):not(.cal-out-month ):not(.cal-weekend):not(:contains('Off')):first .cal-day-number" text as alias "fullTimeDay"

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
        And user click on element ".mat-calendar-body-cell-content" contains alias "@fullTimeDay"
        # And element "mat-tab-body table tr" should be not exist

        #Shared step : When user log timesheet
        Then user forced click on element ".mat-tab-body-wrapper button.mat-flat-button:first"
        Then element ".mat-dialog-container" should be visible
        And it's text should contains "New Timesheet"
        And  user click on element "[name=project]"
        And  user click on element ".mat-select-panel .mat-option:first"
        And  user enter "Lam task Frontend" into field by name "[name=note]"
        And  user enter "7" into field by name "[name=workingTime]"
        And user click on element has text "Save"
        And element ".toast-success" should be exist

        

        Examples: NewDataSet
            | url | username | password |
            |  http://uat.timesheet.nccsoft.vn/ | test6@gmail.com  | 123qwe  |

        @TEST_CASE_1:
    Scenario Outline: Verify users unable to log 2 Timesheet on the day with total working hours > actual working hours
     # Shared step: Given user login ERP Timesheet
        Given user visit page "<url>"
        And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
        And user enter "<password>" into field by placeholder "Password"
        And user click on element "button[type='submit']"
        #Shared step: Then waiting for page loading
        Then waiting for page loading
        
        #Shared step : When user visit My timesheets
        When user forced click on element ".bars"
        And user click on anchor with link "app/main/mytimesheets"
        And user forced click on element ".bars"
        Then user is navigated to page "app/main/mytimesheets"
        Then element "h2" should be visible
        And it's text should contains 'Tardiness Detail'

        #Shared step : And user can select logged Timesheet
        When user click on element ".mat-tab-label-content:contains('0'):first"
        And element "mat-tab-body table tr" should be exist

        #Shared step : When user log timesheet
        Then user forced click on element ".mat-tab-body-wrapper button.mat-flat-button:first"
        Then element ".mat-dialog-container" should be visible
        And it's text should contains "New Timesheet"
        And  user click on element "[name=project]"
        And  user click on element ".mat-select-panel .mat-option:first"
        And  user enter "Lam task Frontend" into field by name "[name=note]"
        And  user enter "8" into field by name "[name=workingTime]"
        And user click on element has text "Save"
        And element "toast-error" should be not exist

        
        Examples: NewDataSet
            | url | username | password |
            |  http://uat.timesheet.nccsoft.vn/ | test6@gmail.com  | 123qwe  |

    @TEST_CASE_1
    Scenario Outline: Verify user who work all day unable to log Timesheet with normal working time > 8h etc
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
        And extract "mat-form-field:contains('Month') .mat-select-value-text span" text as alias "monthRequest"

        #Shared step:And Users can choose the day on which they work all day
        When extract "mwl-calendar-month-cell:not(.cal-past):not(.cal-out-month ):not(.cal-weekend):not(:contains('Off')):eq(1) .cal-day-number" text as alias "fullTimeDay"

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
        And user click on element ".mat-calendar-body-cell-content" contains alias "@fullTimeDay"
        And element "mat-tab-body table tr" should be not exist

        #Shared step : When user log timesheet
        Then user forced click on element ".mat-tab-body-wrapper button.mat-flat-button:first"
        Then element ".mat-dialog-container" should be visible
        And it's text should contains "New Timesheet"
        And  user click on element "[name=project]"
        And  user click on element ".mat-select-panel .mat-option:first"
        And  user enter "Lam task Frontend" into field by name "[name=note]"
        And  user enter "9" into field by name "[name=workingTime]"
        And user click on element has text "Save"
        And element "mat-tab-body table tr" should be not exist

        

        Examples: NewDataSet
            | url | username | password |
            |  http://uat.timesheet.nccsoft.vn/ | test7@gmail.com  | 123qwe  |

Scenario Outline: Verify user who work all day can log Timesheet with normal working time = 8h + OT etc
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
        And extract "mat-form-field:contains('Month') .mat-select-value-text span" text as alias "monthRequest"

        #Shared step:And Users can choose the day on which they work all day
        When extract "mwl-calendar-month-cell:not(.cal-past):not(.cal-out-month ):not(.cal-weekend):not(:contains('Off')):eq(1) .cal-day-number" text as alias "fullTimeDay"

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
        And user click on element ".mat-calendar-body-cell-content" contains alias "@fullTimeDay"
        # And element "mat-tab-body table tr" should be not exist

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
        And element ".toast-success" should be exist

        

        Examples: NewDataSet
            | url | username | password |
            |  http://uat.timesheet.nccsoft.vn/ | test8@gmail.com  | 123qwe  |

    


    
