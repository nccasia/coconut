# 1. Nhân viên không off giờ nào > Check log timesheet với normal working time = 7/8/9h (check cả require field) ok
# 2. Nhân viên không off giờ nào > Check log timesheet với normal working = 8, OT time ok
# 3. Nhân viên off (giờ/morning/afternoon/all day) > Check log timesheet với normal working time = 8h hoặc bằng/nhỏ hơn giờ đi làm (8 - giờ đã log nghỉ)
# 4. Nhân viên off (giờ/morning/afternoon/all day) > Check log timesheet với normal working time bằng đúng giờ đi làm và OT
# 5. Check nhân viên log 2 timesheet (normal working) trong 1 ngày với tổng của 2 timesheet lớn hơn giờ làm việc tiêu chuẩn (8h) hoặc giờ làm việc thực tế sau khi log leave (8h - giờ đã log nghỉ) ok
# 6. Setting để nhân viên không log timesheet được trong tương lai > Check nhân viên log timesheet cho ngày trong tương lai (normal/OT)
# 7. Setting để nhân viên không log được timesheet cho ngày trong quá khứ (tuần trước) > Check nhân viên log timesheet cho ngày trong quá khứ (tuần trước tuần hiện tại)
# 8. Setting để nhân viên log được timesheet trong tương lai > Check nhân viên log timesheet cho ngày trong tương lai (normal/OT)
# 9. Setting để nhân viên log được timesheet cho ngày trong quá khứ > Check nhân viên log timesheet cho ngày trong quá khứ
@TEST_LOG_TIMESHEET
Feature: User can log Timesheet on off day



    # @TEST_CASE_1.3 @STATE_Design
    # Scenario Outline: Verify user sent request off all day
    #     # Shared step: Given user login ERP Timesheet
    #     Given user visit page "<url>"
    #     And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
    #     And user enter "<password>" into field by placeholder "Password"
    #     And user click on element "button[type='submit']"
    #     #Shared step: Then user able to get user-info

    #     #Shared step : When user visit My leave days page
    #     When user forced click on element ".bars"
    #     And user click on anchor with link "app/main/absence-day"
    #     And user forced click on element ".bars"
    #     Then user is navigated to page "app/main/absence-day"
    #     Then element ".header" should be visible
    #     And it's text should contains 'My off days'


    #     #Shared step: User able to get month year request
    #     And extract "mat-form-field:contains('Year') .mat-select-value-text span" text as alias "yearRequestOffFullDay"
    #     And extract "mat-form-field:contains('Month') .mat-select-value-text span" text as alias "monthRequestOffFullDay"

    #     #Shared step: Then waiting for page loading
    #     Then waiting for page loading

    #     #Shared step : When user select day
    #     When set element "mwl-calendar-month-cell:not(:contains('Approved')):not(:contains('Rejected')):not(.cal-out-month):not(.cal-past):not(.cal-weekend):first" as alias "dayRequest"
    #     And extract "mwl-calendar-month-cell:not(:contains('Approved')):not(:contains('Rejected')):not(.cal-out-month):not(.cal-past):not(.cal-weekend):first .cal-day-number" text as alias "dayNumberOffFullDay"
    #     And user click on element by alias "@dayRequest"

    #     #Shared step : And user send request leave all day
    #     And user click on element has text "Send leave request"
    #     Then element ".mat-dialog-container h1" should be visible
    #     And it's text should contains "Submit leave request"
    #     When user forced click on element has text "Absence Type"
    #     And user click on element ".mat-select-panel .mat-option:first-child"
    #     And user value "Test request leave day!" into input with label "Reason"

    #     Then user click on element has text "Save"
    #     And user is able to see element by alias "@dayRequest"
    #     Then element by alias "@dayRequest" should contains "Approved"


    #     Examples: NewDataSet
    #         | url                              | username           | password |
    #         | http://uat.timesheet.nccsoft.vn/ | test9@gmail.com | 123qwe   |

    # @TEST_CASE_1:
    # Scenario Outline: Verify users unable to log Timesheet on the day they are off
    #     # Shared step: Given user login ERP Timesheet
    #     Given user visit page "<url>"
    #     And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
    #     And user enter "<password>" into field by placeholder "Password"
    #     And user click on element "button[type='submit']"
    #     #Shared step: Then waiting for page loading
    #     Then waiting for page loading

    #     #Shared step : When user visit My timesheets
    #     When user forced click on element ".bars"
    #     And user click on anchor with link "app/main/mytimesheets"
    #     And user forced click on element ".bars"
    #     Then user is navigated to page "app/main/mytimesheets"
    #     Then element "h2" should be visible
    #     And it's text should contains 'Tardiness Detail'

    #     #Shared step : And user can choose day to log timesheet
    #     When user click on element "mat-datepicker-toggle"
    #     Then element "mat-calendar" should be visible
    #     And user click on element ".mat-calendar-period-button"
    #     And user click on element ".mat-calendar-body-cell-content" contains alias "@yearRequestOffFullDay"
    #     And user click on element ".mat-calendar-body tr td" is "@monthRequestOffFullDay" child by alias
    #     And user click on element ".mat-calendar-body-cell-content" contains alias "@dayNumberOffFullDay"
    #     And element "mat-tab-body table tr" should be not exist

    #     #Shared step : When user log timesheet with normal working = 8h
    #     Then user forced click on element ".mat-tab-body-wrapper button:first"
    #     Then element ".mat-dialog-container" should be visible
    #     And it's text should contains "New Timesheet"
    #     And  user click on element "[name=project]"
    #     And  user click on element ".mat-select-panel .mat-option:first"
    #     And  user enter "Lam task Frontend" into field by name "[name=note]"
    #     And  user enter "8" into field by name "[name=workingTime]"
    #     And user click on element has text "Save"
    #     And element "mat-tab-body table tr" should be not exist
    #     And element "toast-error" should be not exist


    #     Examples: NewDataSet
    #         | url                              | username           | password |
    #         | http://uat.timesheet.nccsoft.vn/ | test9@gmail.com | 123qwe   |
        
    # @TEST_CASE_1:
    # Scenario Outline: Verify users able to log Timesheet on the day they are off but OT
    #     # Shared step: Given user login ERP Timesheet
    #     Given user visit page "<url>"
    #     And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
    #     And user enter "<password>" into field by placeholder "Password"
    #     And user click on element "button[type='submit']"
    #     #Shared step: Then waiting for page loading
    #     Then waiting for page loading

    #     #Shared step : When user visit My timesheets
    #     When user forced click on element ".bars"
    #     And user click on anchor with link "app/main/mytimesheets"
    #     And user forced click on element ".bars"
    #     Then user is navigated to page "app/main/mytimesheets"
    #     Then element "h2" should be visible
    #     And it's text should contains 'Tardiness Detail'

    #     #Shared step : And user can choose day to log timesheet
    #     When user click on element "mat-datepicker-toggle"
    #     Then element "mat-calendar" should be visible
    #     And user click on element ".mat-calendar-period-button"
    #     And user click on element ".mat-calendar-body-cell-content" contains alias "@yearRequestOffFullDay"
    #     And user click on element ".mat-calendar-body tr td" is "@monthRequestOffFullDay" child by alias
    #     And user click on element ".mat-calendar-body-cell-content" contains alias "@dayNumberOffFullDay"
    #     And element "mat-tab-body table tr" should be not exist

    #     #Shared step : When user log timesheet with normal working = 8h
    #     Then user forced click on element ".mat-tab-body-wrapper button.mat-flat-button:first"
    #     Then element ".mat-dialog-container" should be visible
    #     And it's text should contains "New Timesheet"
    #     And  user click on element "[name=project]"
    #     And  user click on element ".mat-select-panel .mat-option:first"
    #     And  user enter "Lam task Frontend" into field by name "[name=note]"
    #     And  user enter "8" into field by name "[name=workingTime]"
    #     And  user click on element "[name=typeOfWorks]"
    #     And  user click on element ".mat-select-panel .mat-option:contains('Overtime')"
    #     And user click on element has text "Save"
    #     And element "mat-tab-body table tr" should be exist
    #     And element "toast-success" should be not exist


    #     Examples: NewDataSet
    #         | url                              | username           | password |
    #         | http://uat.timesheet.nccsoft.vn/ | test9@gmail.com | 123qwe   |

    # @TEST_CASE_1.3 @STATE_Design
    # Scenario Outline: Verify user sent request for hourly leave
    #     # Shared step: Given user login ERP Timesheet
    #     Given user visit page "<url>"
    #     And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
    #     And user enter "<password>" into field by placeholder "Password"
    #     And user click on element "button[type='submit']"

    #     #Shared step : And waiting for page loading
    #     Then waiting for page loading

    #     #Shared step : When user visit My leave days page
    #     When user forced click on element ".bars"
    #     And user click on anchor with link "app/main/absence-day"
    #     And user forced click on element ".bars"
    #     Then user is navigated to page "app/main/absence-day"
    #     Then element ".header" should be visible
    #     And it's text should contains 'My off days'



    #     #Shared step: User able to get month year request
    #     And extract "mat-form-field:contains('Year') .mat-select-value-text span" text as alias "yearRequest"
    #     And extract "mat-form-field:contains('Month') .mat-select-value-text span" text as alias "monthRequest"
    #     #Shared step : Then waiting for page loading
    #     Then waiting for page loading
    #     #Shared step : When user select day
    #     When set element "mwl-calendar-month-cell:not(.cal-weekend):not(.cal-past):not(.cal-out-month):not(:contains('Approved')):not(:contains('Rejected')):first" as alias "dayRequest"
    #     And extract "mwl-calendar-month-cell:not(.cal-weekend):not(.cal-past):not(.cal-out-month):not(:contains('Approved')):not(:contains('Rejected')):first .cal-day-number" text as alias "dayNumber"
    #     #Shared step : When user send leave day

    #     And user click on element by alias "@dayRequest"
    #     And user click on element by alias "@dayRequest"
    #     And user click on element by alias "@dayRequest"
    #     And user click on element by alias "@dayRequest"
    #     Then element ".mat-dialog-container" should be visible
    #     And  user enter "2.3" into field by name "[name=time]"
    #     Then user click on element has text "Save"

    #     And user click on element has text "Send leave request"
    #     Then element ".mat-dialog-container h1" should be visible
    #     And it's text should contains "Submit leave request"
    #     When user forced click on element has text "Absence Type"
    #     And user click on element ".mat-select-panel .mat-option:first-child"
    #     And user value "Test request leave day!" into input with label "Reason"

    #     Then user click on element has text "Save"
    #     And user is able to see element by alias "@dayRequest"
    #     Then element by alias "@dayRequest" should contains "Approved"


    #     Examples: NewDataSet
    #         | url                              | username           | password |
    #         | http://uat.timesheet.nccsoft.vn/ | test9@gmail.com | 123qwe   |


    # @TEST_CASE_1:
    # Scenario Outline: Verify users able to log Timesheet on the day they are leave with actual working hour
    #     # Shared step: Given user login ERP Timesheet
    #     Given user visit page "<url>"
    #     And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
    #     And user enter "<password>" into field by placeholder "Password"
    #     And user click on element "button[type='submit']"
    #     #Shared step: Then waiting for page loading
    #     Then waiting for page loading

    #     #Shared step : When user visit My timesheets
    #     When user forced click on element ".bars"
    #     And user click on anchor with link "app/main/mytimesheets"
    #     And user forced click on element ".bars"
    #     Then user is navigated to page "app/main/mytimesheets"
    #     Then element "h2" should be visible
    #     And it's text should contains 'Tardiness Detail'

    #     #Shared step : And user can choose day to log timesheet
    #     When user click on element "mat-datepicker-toggle"
    #     Then element "mat-calendar" should be visible
    #     And user click on element ".mat-calendar-period-button"
    #     And user click on element ".mat-calendar-body-cell-content" contains alias "@yearRequest"
    #     And user click on element ".mat-calendar-body tr td" is "@monthRequest" child by alias
    #     And user click on element ".mat-calendar-body-cell-content" contains alias "@dayNumber"
    #     # And element "mat-tab-body table tr" should be not exist

    #     #Shared step : When user log timesheet
    #     Then user forced click on element ".mat-tab-body-wrapper button.mat-flat-button:first"
    #     Then element ".mat-dialog-container" should be visible
    #     And it's text should contains "New Timesheet"
    #     And  user click on element "[name=project]"
    #     And  user click on element ".mat-select-panel .mat-option:first"
    #     And  user enter "Lam task Frontend" into field by name "[name=note]"
    #     And  user enter "5.7" into field by name "[name=workingTime]"
    #     And user click on element has text "Save"
    #     And element "mat-tab-body table tr" should be exist
    #     And element "toast-success" should be not exist


    #     Examples: NewDataSet
    #         | url                              | username           | password |
    #         | http://uat.timesheet.nccsoft.vn/ | test9@gmail.com | 123qwe   |

    #     @TEST_CASE_1.3 @STATE_Design
    # Scenario Outline: Verify user sent request for hourly leave
    #     # Shared step: Given user login ERP Timesheet
    #     Given user visit page "<url>"
    #     And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
    #     And user enter "<password>" into field by placeholder "Password"
    #     And user click on element "button[type='submit']"

    #     #Shared step : And waiting for page loading
    #     Then waiting for page loading

    #     #Shared step : When user visit My leave days page
    #     When user forced click on element ".bars"
    #     And user click on anchor with link "app/main/absence-day"
    #     And user forced click on element ".bars"
    #     Then user is navigated to page "app/main/absence-day"
    #     Then element ".header" should be visible
    #     And it's text should contains 'My off days'



    #     #Shared step: User able to get month year request
    #     And extract "mat-form-field:contains('Year') .mat-select-value-text span" text as alias "yearRequest"
    #     And extract "mat-form-field:contains('Month') .mat-select-value-text span" text as alias "monthRequest"
    #     #Shared step : Then waiting for page loading
    #     Then waiting for page loading
    #     #Shared step : When user select day
    #     When set element "mwl-calendar-month-cell:not(.cal-weekend):not(.cal-past):not(.cal-out-month):not(:contains('Approved')):not(:contains('Rejected')):first" as alias "dayRequest"
    #     And extract "mwl-calendar-month-cell:not(.cal-weekend):not(.cal-past):not(.cal-out-month):not(:contains('Approved')):not(:contains('Rejected')):first .cal-day-number" text as alias "dayNumber"
    #     #Shared step : When user send leave day

    #     And user click on element by alias "@dayRequest"
    #     And user click on element by alias "@dayRequest"
    #     And user click on element by alias "@dayRequest"
    #     And user click on element by alias "@dayRequest"
    #     Then element ".mat-dialog-container" should be visible
    #     And  user enter "2.3" into field by name "[name=time]"
    #     Then user click on element has text "Save"

    #     And user click on element has text "Send leave request"
    #     Then element ".mat-dialog-container h1" should be visible
    #     And it's text should contains "Submit leave request"
    #     When user forced click on element has text "Absence Type"
    #     And user click on element ".mat-select-panel .mat-option:first-child"
    #     And user value "Test request leave day!" into input with label "Reason"

    #     Then user click on element has text "Save"
    #     And user is able to see element by alias "@dayRequest"
    #     Then element by alias "@dayRequest" should contains "Approved"


    #     Examples: NewDataSet
    #         | url                              | username           | password |
    #         | http://uat.timesheet.nccsoft.vn/ | test10@gmail.com | 123qwe   |


    
    #     @TEST_CASE_1:
    # Scenario Outline: Verify users able to log Timesheet on the day they are leave with actual working hour and OT
    #     # Shared step: Given user login ERP Timesheet
    #     Given user visit page "<url>"
    #     And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
    #     And user enter "<password>" into field by placeholder "Password"
    #     And user click on element "button[type='submit']"
    #     #Shared step: Then waiting for page loading
    #     Then waiting for page loading

    #     #Shared step : When user visit My timesheets
    #     When user forced click on element ".bars"
    #     And user click on anchor with link "app/main/mytimesheets"
    #     And user forced click on element ".bars"
    #     Then user is navigated to page "app/main/mytimesheets"
    #     Then element "h2" should be visible
    #     And it's text should contains 'Tardiness Detail'

    #     #Shared step : And user can choose day to log timesheet
    #     When user click on element "mat-datepicker-toggle"
    #     Then element "mat-calendar" should be visible
    #     And user click on element ".mat-calendar-period-button"
    #     And user click on element ".mat-calendar-body-cell-content" contains alias "@yearRequest"
    #     And user click on element ".mat-calendar-body tr td" is "@monthRequest" child by alias
    #     And user click on element ".mat-calendar-body-cell-content" contains alias "@dayNumber"
    #     # And element "mat-tab-body table tr" should be not exist

    #     #Shared step : When user log timesheet
    #     Then user forced click on element ".mat-tab-body-wrapper button.mat-flat-button:first"
    #     Then element ".mat-dialog-container" should be visible
    #     And it's text should contains "New Timesheet"
    #     And  user click on element "[name=project]"
    #     And  user click on element ".mat-select-panel .mat-option:first"
    #     And  user enter "Lam task Frontend" into field by name "[name=note]"
    #     And  user enter "5.7" into field by name "[name=workingTime]"
    #     And  user click on element "[name=typeOfWorks]"
    #     And  user click on element ".mat-select-panel .mat-option:contains('Overtime')"
    #     And user click on element has text "Save"
    #     And element "mat-tab-body table tr" should be exist
    #     And element "toast-success" should be not exist


    #     Examples: NewDataSet
    #         | url                              | username           | password |
    #         | http://uat.timesheet.nccsoft.vn/ | test10@gmail.com | 123qwe   |


    @TEST_CASE_1.3 @STATE_Design
    Scenario Outline: Verify user sent request off morning
        # Shared step: Given user login ERP Timesheet
        Given user visit page "<url>"
        And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
        And user enter "<password>" into field by placeholder "Password"
        And user click on element "button[type='submit']"

        #Shared step : And waiting for page loading
        Then waiting for page loading

        #Shared step : When user visit My leave days page
        When user forced click on element ".bars"
        And user click on anchor with link "app/main/absence-day"
        And user forced click on element ".bars"
        Then user is navigated to page "app/main/absence-day"
        Then element ".header" should be visible
        And it's text should contains 'My off days'

        #Shared step: User able to get month year request
        And extract "mat-form-field:contains('Year') .mat-select-value-text span" text as alias "yearRequest"
        And extract "mat-form-field:contains('Month') .mat-select-value-text span" text as alias "monthRequest"
        #Shared step : Then waiting for page loading
        Then waiting for page loading
        #Shared step : When user select day
        When set element "mwl-calendar-month-cell:not(.cal-weekend):not(.cal-past):not(.cal-out-month):not(:contains('Approved')):not(:contains('Rejected')):first" as alias "dayRequest"
        And extract "mwl-calendar-month-cell:not(.cal-weekend):not(.cal-past):not(.cal-out-month):not(:contains('Approved')):not(:contains('Rejected')):first .cal-day-number" text as alias "dayNumber"
        #Shared step : When user send leave day

        And user click on element by alias "@dayRequest"
        And user click on element by alias "@dayRequest"
        And user click on element has text "Send leave request"
        Then element ".mat-dialog-container h1" should be visible
        And it's text should contains "Submit leave request"
        When user forced click on element has text "Absence Type"
        And user click on element ".mat-select-panel .mat-option:first-child"
        And user value "Test request leave day!" into input with label "Reason"

        Then user click on element has text "Save"
        And user is able to see element by alias "@dayRequest"
        Then element by alias "@dayRequest" should contains "Approved"


        Examples: NewDataSet
            | url                              | username           | password |
            | http://uat.timesheet.nccsoft.vn/ | test13@gmail.com | 123qwe   |


    @TEST_CASE_1:
    Scenario Outline: Verify users unable to log Timesheet on the day they are off morning with working hour = 4.5
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

        #Shared step : And user can choose day to log timesheet
        When user click on element "mat-datepicker-toggle"
        Then element "mat-calendar" should be visible
        And user click on element ".mat-calendar-period-button"
        And user click on element ".mat-calendar-body-cell-content" contains alias "@yearRequest"
        And user click on element ".mat-calendar-body tr td" is "@monthRequest" child by alias
        And user click on element ".mat-calendar-body-cell-content" contains alias "@dayNumber"
        And element "mat-tab-body table tr" should be not exist

        #Shared step : When user log timesheet
        Then user forced click on element ".mat-tab-body-wrapper button.mat-flat-button:first"
        Then element ".mat-dialog-container" should be visible
        And it's text should contains "New Timesheet"
        And  user click on element "[name=project]"
        And  user click on element ".mat-select-panel .mat-option:first"
        And  user enter "Lam task Frontend" into field by name "[name=note]"
        And  user enter "4.5" into field by name "[name=workingTime]"
        And user click on element has text "Save"
        And element "mat-tab-body table tr" should be exist
        And element "toast-success" should be not exist


        Examples: NewDataSet
            | url                              | username           | password |
            | http://uat.timesheet.nccsoft.vn/ | test13@gmail.com | 123qwe   |

     @TEST_CASE_1.3 @STATE_Design
    Scenario Outline: Verify user sent request off morning
        # Shared step: Given user login ERP Timesheet
        Given user visit page "<url>"
        And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
        And user enter "<password>" into field by placeholder "Password"
        And user click on element "button[type='submit']"

        #Shared step : And waiting for page loading
        Then waiting for page loading

        #Shared step : When user visit My leave days page
        When user forced click on element ".bars"
        And user click on anchor with link "app/main/absence-day"
        And user forced click on element ".bars"
        Then user is navigated to page "app/main/absence-day"
        Then element ".header" should be visible
        And it's text should contains 'My off days'

        #Shared step: User able to get month year request
        And extract "mat-form-field:contains('Year') .mat-select-value-text span" text as alias "yearRequest"
        And extract "mat-form-field:contains('Month') .mat-select-value-text span" text as alias "monthRequest"
        #Shared step : Then waiting for page loading
        Then waiting for page loading
        #Shared step : When user select day
        When set element "mwl-calendar-month-cell:not(.cal-weekend):not(.cal-past):not(.cal-out-month):not(:contains('Approved')):not(:contains('Rejected')):first" as alias "dayRequest"
        And extract "mwl-calendar-month-cell:not(.cal-weekend):not(.cal-past):not(.cal-out-month):not(:contains('Approved')):not(:contains('Rejected')):first .cal-day-number" text as alias "dayNumber"
        #Shared step : When user send leave day

        And user click on element by alias "@dayRequest"
        And user click on element by alias "@dayRequest"
        And user click on element has text "Send leave request"
        Then element ".mat-dialog-container h1" should be visible
        And it's text should contains "Submit leave request"
        When user forced click on element has text "Absence Type"
        And user click on element ".mat-select-panel .mat-option:first-child"
        And user value "Test request leave day!" into input with label "Reason"

        Then user click on element has text "Save"
        And user is able to see element by alias "@dayRequest"
        Then element by alias "@dayRequest" should contains "Approved"


        Examples: NewDataSet
            | url                              | username           | password |
            | http://uat.timesheet.nccsoft.vn/ | test13@gmail.com | 123qwe   |


    @TEST_CASE_1:
    Scenario Outline: Verify users able to log Timesheet on the day they are off morning with working hour = 4.5 + OT
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

        #Shared step : And user can choose day to log timesheet
        When user click on element "mat-datepicker-toggle"
        Then element "mat-calendar" should be visible
        And user click on element ".mat-calendar-period-button"
        And user click on element ".mat-calendar-body-cell-content" contains alias "@yearRequest"
        And user click on element ".mat-calendar-body tr td" is "@monthRequest" child by alias
        And user click on element ".mat-calendar-body-cell-content" contains alias "@dayNumber"
        And element "mat-tab-body table tr" should be not exist

        #Shared step : When user log timesheet
        Then user forced click on element ".mat-tab-body-wrapper button.mat-flat-button:first"
        Then element ".mat-dialog-container" should be visible
        And it's text should contains "New Timesheet"
        And  user click on element "[name=project]"
        And  user click on element ".mat-select-panel .mat-option:first"
        And  user enter "Lam task Frontend" into field by name "[name=note]"
        And  user enter "4.5" into field by name "[name=workingTime]"
        And  user click on element "[name=typeOfWorks]"
        And  user click on element ".mat-select-panel .mat-option:contains('Overtime')"
        And user click on element has text "Save"
        And element "mat-tab-body table tr" should be exist
        And element "toast-success" should be not exist


        Examples: NewDataSet
            | url                              | username           | password |
            | http://uat.timesheet.nccsoft.vn/ | test13@gmail.com | 123qwe   |

    # @TEST_CASE_1.3 @STATE_Design
    # Scenario Outline: Verify user sent request off afternoon
    #     # Shared step: Given user login ERP Timesheet
    #     Given user visit page "<url>"
    #     And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
    #     And user enter "<password>" into field by placeholder "Password"
    #     And user click on element "button[type='submit']"

    #     #Shared step : And waiting for page loading
    #     Then waiting for page loading

    #     #Shared step : When user visit My leave days page
    #     When user forced click on element ".bars"
    #     And user click on anchor with link "app/main/absence-day"
    #     And user forced click on element ".bars"
    #     Then user is navigated to page "app/main/absence-day"
    #     Then element ".header" should be visible
    #     And it's text should contains 'My off days'



    #     #Shared step: User able to get month year request
    #     And extract "mat-form-field:contains('Year') .mat-select-value-text span" text as alias "yearRequest"
    #     And extract "mat-form-field:contains('Month') .mat-select-value-text span" text as alias "monthRequest"
    #     #Shared step : Then waiting for page loading
    #     Then waiting for page loading
    #     #Shared step : When user select day
    #     When set element "mwl-calendar-month-cell:not(.cal-weekend):not(.cal-past):not(.cal-out-month):not(:contains('Approved')):not(:contains('Rejected')):first" as alias "dayRequest"
    #     And extract "mwl-calendar-month-cell:not(.cal-weekend):not(.cal-past):not(.cal-out-month):not(:contains('Approved')):not(:contains('Rejected')):first .cal-day-number" text as alias "dayNumber"
    #     #Shared step : When user send leave day

    #     And user click on element by alias "@dayRequest"
    #     And user click on element by alias "@dayRequest"
    #     And user click on element by alias "@dayRequest"
    #     And user click on element has text "Send leave request"
    #     Then element ".mat-dialog-container h1" should be visible
    #     And it's text should contains "Submit leave request"
    #     When user forced click on element has text "Absence Type"
    #     And user click on element ".mat-select-panel .mat-option:first-child"
    #     And user value "Test request leave day!" into input with label "Reason"

    #     Then user click on element has text "Save"
    #     And user is able to see element by alias "@dayRequest"
    #     Then element by alias "@dayRequest" should contains "Approved"


    #     Examples: NewDataSet
    #         | url                              | username           | password |
    #         | http://uat.timesheet.nccsoft.vn/ | test12@gmail.com | 123qwe   |


    # @TEST_CASE_1:
    # Scenario Outline: Verify usersable to log Timesheet on the day they are off afternoon with working hour = 3.5
    #     # Shared step: Given user login ERP Timesheet
    #     Given user visit page "<url>"
    #     And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
    #     And user enter "<password>" into field by placeholder "Password"
    #     And user click on element "button[type='submit']"
    #     #Shared step: Then waiting for page loading
    #     Then waiting for page loading

    #     #Shared step : When user visit My timesheets
    #     When user forced click on element ".bars"
    #     And user click on anchor with link "app/main/mytimesheets"
    #     And user forced click on element ".bars"
    #     Then user is navigated to page "app/main/mytimesheets"
    #     Then element "h2" should be visible
    #     And it's text should contains 'Tardiness Detail'

    #     #Shared step : And user can choose day to log timesheet
    #     When user click on element "mat-datepicker-toggle"
    #     Then element "mat-calendar" should be visible
    #     And user click on element ".mat-calendar-period-button"
    #     And user click on element ".mat-calendar-body-cell-content" contains alias "@yearRequest"
    #     And user click on element ".mat-calendar-body tr td" is "@monthRequest" child by alias
    #     And user click on element ".mat-calendar-body-cell-content" contains alias "@dayNumber"
    #     And element "mat-tab-body table tr" should be not exist

    #     #Shared step : When user log timesheet
    #     Then user forced click on element ".mat-tab-body-wrapper button.mat-flat-button:first"
    #     Then element ".mat-dialog-container" should be visible
    #     And it's text should contains "New Timesheet"
    #     And  user click on element "[name=project]"
    #     And  user click on element ".mat-select-panel .mat-option:first"
    #     And  user enter "Lam task Frontend" into field by name "[name=note]"
    #     And  user enter "3.5" into field by name "[name=workingTime]"
    #     And user click on element has text "Save"
    #     And element "mat-tab-body table tr" should be exist
    #     And element "toast-success" should be not exist


    #     Examples: NewDataSet
    #         | url                              | username           | password |
    #         | http://uat.timesheet.nccsoft.vn/ | test12@gmail.com | 123qwe   |

    #     @TEST_CASE_1.3 @STATE_Design
    # Scenario Outline: Verify user sent request off afternoon
    #     # Shared step: Given user login ERP Timesheet
    #     Given user visit page "<url>"
    #     And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
    #     And user enter "<password>" into field by placeholder "Password"
    #     And user click on element "button[type='submit']"

    #     #Shared step : And waiting for page loading
    #     Then waiting for page loading

    #     #Shared step : When user visit My leave days page
    #     When user forced click on element ".bars"
    #     And user click on anchor with link "app/main/absence-day"
    #     And user forced click on element ".bars"
    #     Then user is navigated to page "app/main/absence-day"
    #     Then element ".header" should be visible
    #     And it's text should contains 'My off days'



    #     #Shared step: User able to get month year request
    #     And extract "mat-form-field:contains('Year') .mat-select-value-text span" text as alias "yearRequest"
    #     And extract "mat-form-field:contains('Month') .mat-select-value-text span" text as alias "monthRequest"
    #     #Shared step : Then waiting for page loading
    #     Then waiting for page loading
    #     #Shared step : When user select day
    #     When set element "mwl-calendar-month-cell:not(.cal-weekend):not(.cal-past):not(.cal-out-month):not(:contains('Approved')):not(:contains('Rejected')):first" as alias "dayRequest"
    #     And extract "mwl-calendar-month-cell:not(.cal-weekend):not(.cal-past):not(.cal-out-month):not(:contains('Approved')):not(:contains('Rejected')):first .cal-day-number" text as alias "dayNumber"
    #     #Shared step : When user send leave day

    #     And user click on element by alias "@dayRequest"
    #     And user click on element by alias "@dayRequest"
    #     And user click on element by alias "@dayRequest"
    #     And user click on element has text "Send leave request"
    #     Then element ".mat-dialog-container h1" should be visible
    #     And it's text should contains "Submit leave request"
    #     When user forced click on element has text "Absence Type"
    #     And user click on element ".mat-select-panel .mat-option:first-child"
    #     And user value "Test request leave day!" into input with label "Reason"

    #     Then user click on element has text "Save"
    #     And user is able to see element by alias "@dayRequest"
    #     Then element by alias "@dayRequest" should contains "Approved"


    #     Examples: NewDataSet
    #         | url                              | username           | password |
    #         | http://uat.timesheet.nccsoft.vn/ | test12@gmail.com | 123qwe   |

    #     @TEST_CASE_1:
    #     Scenario Outline: Verify usersable to log Timesheet on the day they are off afternoon with working hour = 3.5 + OT
    #     # Shared step: Given user login ERP Timesheet
    #     Given user visit page "<url>"
    #     And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
    #     And user enter "<password>" into field by placeholder "Password"
    #     And user click on element "button[type='submit']"
    #     #Shared step: Then waiting for page loading
    #     Then waiting for page loading

    #     #Shared step : When user visit My timesheets
    #     When user forced click on element ".bars"
    #     And user click on anchor with link "app/main/mytimesheets"
    #     And user forced click on element ".bars"
    #     Then user is navigated to page "app/main/mytimesheets"
    #     Then element "h2" should be visible
    #     And it's text should contains 'Tardiness Detail'

    #     #Shared step : And user can choose day to log timesheet
    #     When user click on element "mat-datepicker-toggle"
    #     Then element "mat-calendar" should be visible
    #     And user click on element ".mat-calendar-period-button"
    #     And user click on element ".mat-calendar-body-cell-content" contains alias "@yearRequest"
    #     And user click on element ".mat-calendar-body tr td" is "@monthRequest" child by alias
    #     And user click on element ".mat-calendar-body-cell-content" contains alias "@dayNumber"
    #     And element "mat-tab-body table tr" should be not exist

    #     #Shared step : When user log timesheet
    #     Then user forced click on element ".mat-tab-body-wrapper button.mat-flat-button:first"
    #     Then element ".mat-dialog-container" should be visible
    #     And it's text should contains "New Timesheet"
    #     And  user click on element "[name=project]"
    #     And  user click on element ".mat-select-panel .mat-option:first"
    #     And  user enter "Lam task Frontend" into field by name "[name=note]"
    #     And  user enter "3.5" into field by name "[name=workingTime]"
    #     And  user click on element "[name=typeOfWorks]"
    #     And  user click on element ".mat-select-panel .mat-option:contains('Overtime')"
    #     And user click on element has text "Save"
    #     And element "mat-tab-body table tr" should be exist
    #     And element "toast-success" should be not exist


    #     Examples: NewDataSet
    #         | url                              | username           | password |
    #         | http://uat.timesheet.nccsoft.vn/ | test12@gmail.com | 123qwe   |
        



