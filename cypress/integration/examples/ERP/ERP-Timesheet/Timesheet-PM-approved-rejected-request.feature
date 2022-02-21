@TEST_TIMESHEET_LOG_REQUEST
Feature: User sent request and PM reject this request then user able to sent request in this day again and pm approved the rejected request above
    @TEST_CASE_1.3 @STATE_Design
    Scenario Outline: Verify user sent request
        # Shared step: Given user login ERP Timesheet
        Given user visit page "<url>"
        And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
        And user enter "<password>" into field by placeholder "Password"
        And user click on element "button" contains "Log in"
        #Shared step: Then user able to get user-info
        When user forced click on element ".bars"
        And extract ".user-info .name" text as alias "userName"

        #Shared step : And waiting for page loading
        Then waiting for page loading

        #Shared step : When user visit My leave days page

        And user click on anchor with link "app/main/absence-day"
        And user forced click on element ".bars"
        Then user is navigated to page "app/main/absence-day"
        Then element ".header" should be visible
        And it's text should contains 'My off days'

        #Shared step : Then waiting for page loading
        Then waiting for page loading

        #Shared step: User able to get month year request
        And extract "mat-form-field:contains('Year') .mat-select-value-text span" text as alias "yearRequest"
        And extract "mat-form-field:contains('Month') .mat-select-value-text span" text as alias "monthRequest"

        #Shared step : When user send leave day
        When set element "mwl-calendar-month-cell:not(.cal-out-month):not(.all-day-absence):not(morning-absence):not(.afternoon-absence):not(.custom-absence-time):not(.back-red):last" as alias "dayRequest"
        And extract "mwl-calendar-month-cell:not(.cal-out-month):not(.all-day-absence):not(morning-absence):not(.afternoon-absence):not(.custom-absence-time):not(.back-red):last .cal-day-number" text as alias "dayNumberRequest"
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
            | url                              | username       | password |
            | http://dev.timesheet.nccsoft.vn/ | north@ncc.asia | 123qwe   |



    # # ###

    @TEST_CASE_1.3 @STATE_Design
    Scenario Outline: Verify PM able to reject request
        # Shared step: Given user login ERP Timesheet
        Given user visit page "<url>"
        And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
        And user enter "<password>" into field by placeholder "Password"
        And user click on element "button" contains "Log in"

        #Shared step : Then waiting for page loading
        Then waiting for page loading

        #Shared step : When user visit Manage team working calendar page
        When user forced click on element ".bars"
        And user click on anchor with link "off-day-project" and contains "Manage team working calendar"
        And user forced click on element ".bars"
        Then waiting for page loading
        Then element ".header h2" should be visible
        And it's text should contains 'Manage team working calendar'

        #Shared step : Then waiting for page loading
        Then waiting for page loading

        # #Shared step : When PM reject request
        When user click on element "mat-form-field:contains('Year')"
        And user click on day "mat-option" contains "@yearRequest"
        When user click on element "mat-form-field:contains('Month')"
        And user click on day "mat-option" contains "@monthRequest"
        When user click on day "mwl-calendar-month-cell.cal-has-events .cal-day-number" contains "@dayNumberRequest"
        Then element ".mat-dialog-container h4" should be exist
        And it's text should contains "List user"
        Then user click on sub element ".reject-button" in element "tr" by alias "@userName"
        Then user able to see sub element ".approve-button" in element "tr" by alias "@userName"

        Examples: NewDataSet
            | url                              | username     | password |
            | http://dev.timesheet.nccsoft.vn/ | duong.nguyen | 123qwe   |


    # ###
    @TEST_CASE_1.3 @STATE_Design
    Scenario Outline: Verify user can send request on the day that PM rejected request
        # Shared step: Given user login ERP Timesheet
        Given user visit page "<url>"
        And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
        And user enter "<password>" into field by placeholder "Password"
        And user click on element "button" contains "Log in"
        #Shared step: Then user can get user-info
        When user forced click on element ".bars"

        #Shared step : Then waiting for page loading
        Then waiting for page loading

        #Shared step : When user visit My leave days page

        And user click on anchor with link "app/main/absence-day"
        And user forced click on element ".bars"
        Then user is navigated to page "app/main/absence-day"
        Then element ".header" should be visible
        And it's text should contains 'My off days'

        #Shared step : Then waiting for page loading
        Then waiting for page loading

        #Shared step : When user send request on the day that PM rejected request
        When user click on element "mat-form-field:contains('Year')"
        And user click on day "mat-option" contains "@yearRequest"
        When user click on element "mat-form-field:contains('Month')"
        And user click on day "mat-option" contains "@monthRequest"
        And user click on day "mwl-calendar-month-cell .cal-day-number" contains "@dayNumberRequest"

        And user click on element has text "Send leave request"
        Then element ".mat-dialog-container h1" should be visible
        And it's text should contains "Submit leave request"
        When user forced click on element has text "Absence Type"
        And user click on element ".mat-select-panel .mat-option:first-child"
        And user value "Test request leave day!" into input with label "Reason"

        Then user click on element has text "Save"
        And user able to see sub element ".day-off-state-approved" in element "mwl-calendar-month-cell" by alias "@dayNumberRequest"

        Examples: NewDataSet
            | url                              | username       | password |
            | http://dev.timesheet.nccsoft.vn/ | north@ncc.asia | 123qwe   |

    # ###
    @TEST_CASE_1.3 @STATE_Design
    Scenario Outline: Verify PM approved the rejected request
        # Shared step: Given user login ERP Timesheet
        Given user visit page "<url>"
        And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
        And user enter "<password>" into field by placeholder "Password"
        And user click on element "button" contains "Log in"

        #Shared step : Then waiting for page loading
        Then waiting for page loading

        #Shared step : When user visit Manage team working calendar page
        When user forced click on element ".bars"
        And user click on anchor with link "off-day-project" and contains "Manage team working calendar"
        And user forced click on element ".bars"
        Then waiting for page loading
        Then element ".header h2" should be visible
        And it's text should contains 'Manage team working calendar'

        #Shared step : Then waiting for page loading
        Then waiting for page loading

        #Shared step : When Show all rejected request
        And element "mat-checkbox:contains('Show request rejected') input" should be exist
        And user check element "mat-checkbox:contains('Show request rejected') input"

        #Shared step : And PM approved the rejected request

        When user click on element "mat-form-field:contains('Year')"
        And user click on day "mat-option" contains "@yearRequest"
        When user click on element "mat-form-field:contains('Month')"
        And user click on day "mat-option" contains "@monthRequest"
        When user click on day "mwl-calendar-month-cell.cal-has-events .cal-day-number" contains "@dayNumberRequest"
        Then element ".mat-dialog-container h4" should be exist
        And it's text should contains "List user"
        When user click on sub element ".approve-button:first" in element "tr" by alias "@userName"
        Then user is able to see element "#toast-container" contains "Already have the approved request in this day!"

        Examples: NewDataSet
            | url                              | username     | password |
            | http://dev.timesheet.nccsoft.vn/ | duong.nguyen | 123qwe   |


###
