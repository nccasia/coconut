@TEST_TIMESHEET_ERP
Feature:In order to submit my timesheet, as an user I can request and log my timesheet (chức năng của module)


    ##################################################################################
    # @TEST_CASE_1 @STATE_Design
    # Scenario Outline: Verify user unable to request leave day on off days
    #     # Shared step: Given user login ERP Timesheet
    #     Given user visit page "<url>"
    #     And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
    #     And user enter "<password>" into field by placeholder "Password"
    #     And user click on element "button" contains "Log in"

    #     #Shared step: Then waiting for page loading
    #     Then waiting for page loading


    #     #Shared step : When user visit My leave days
    #     When user forced click on element ".bars"
    #     And user click on anchor with link "app/main/absence-day"
    #     And user forced click on element ".bars"
    #     Then user is navigated to page "app/main/absence-day"
    #     Then element ".header" should be visible
    #     And it's text should contains 'My off days'

    #     #Shared step : And user send request
    #     When user click on element ".cal-days .back-red:first"
    #     Then it's text should have contains 'Off'


    #     Examples: NewDataSet
    #         | url                              | username                | password |
    #         | http://dev.timesheet.nccsoft.vn/ | trang.auto@gmail.com | 123qwe   |



        #     ###########################################################
#             @TEST_CASE_1.3 @STATE_Design
#             Scenario Outline: Verify user able to request leave day on day in past
#             # Shared step: Given user login ERP Timesheet
#             Given user visit page "<url>"
#             And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
#             And user enter "<password>" into field by placeholder "Password"
#             And user click on element "button" contains "Log in"

             #Shared step : Then waiting for page loading
#             Then waiting for page loading

#            #Shared step : When user visit My leave days page
#             When user forced click on element ".bars"
#             And user click on anchor with link "app/main/absence-day"
#             And user forced click on element ".bars"
#             Then user is navigated to page "app/main/absence-day"
#             And element ".header" should be visible
#             And it's text should contains 'My off days'

#             #Shared step : Then waiting for page loading
#             Then waiting for page loading

#             #Shared step : When user send request
#             When set element "mwl-calendar-month-cell.cal-past:not(.all-day-absence):not(morning-absence):not(.afternoon-absence):not(.custom-absence-time):not(.back-red):last" as alias "dayInPast"
#             When user click on element by alias "@dayInPast"
#             And user click on element has text "Send leave request"
#             Then element ".mat-dialog-container h1" should be visible
#             And it's text should contains "Submit leave request"
#             When user forced click on element has text "Absence Type"
#             And user click on element ".mat-select-panel .mat-option:first-child"
#             And user value "Test request leave day!" into input with label "Reason"

#             Then user click on element has text "Save"
#             And user is able to see element by alias "@dayInPast"
#             Then element by alias "@dayInPast" should contains "Approved"
            

#          Examples: NewDataSet
#             | url                              | username                | password |
#             | http://dev.timesheet.nccsoft.vn/ | trang.auto@gmail.com | 123qwe   |


#         # #     ###
#             @TEST_CASE_1.3 @STATE_Design
#             Scenario Outline: Verify user able to request leave day on current day
#             # Shared step: Given user login ERP Timesheet
#             Given user visit page "<url>"
#             And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
#             And user enter "<password>" into field by placeholder "Password"
#             And user click on element "button" contains "Log in"

              ##Shared step : Then waiting for page loading
#             Then waiting for page loading

#             #Shared step : When user visit My leave days
#             When user forced click on element ".bars"
#             And user click on anchor with link "app/main/absence-day"
#             And user forced click on element ".bars"
#             Then user is navigated to page "app/main/absence-day"
#             Then element ".header" should be visible
#             And it's text should contains 'My off days'
            
            
#             #Shared step : Then waiting for page loading
#             Then waiting for page loading

#             #Shared step : When user send leave day
#             When set element "mwl-calendar-month-cell.cal-today:not(.all-day-absence):not(morning-absence):not(.afternoon-absence):not(.custom-absence-time):not(.back-red)" as alias "today"
#             When user click on element by alias "@today"
#             And user click on element has text "Send leave request"
#             Then element ".mat-dialog-container h1" should be visible
#             And it's text should contains "Submit leave request"
#             When user forced click on element has text "Absence Type"
#             And user click on element ".mat-select-panel .mat-option:first-child"
#             And user value "Test request leave day!" into input with label "Reason"

#             Then user click on element has text "Save"
#             And user is able to see element by alias "@today"
#             Then element by alias "@today" should contains "Approved"


#         Examples: NewDataSet
#                 | url                              | username                | password |
#                 | http://dev.timesheet.nccsoft.vn/ | trang.auto@gmail.com | 123qwe   |


#         # #     ###
#             @TEST_CASE_1.3 @STATE_Design
#             Scenario Outline: Verify user able to request leave future day
#             # Shared step: Given user login ERP Timesheet
#             Given user visit page "<url>"
#             And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
#             And user enter "<password>" into field by placeholder "Password"
#             And user click on element "button" contains "Log in"
            
              #Shared step : Then waiting for page loading
#             Then waiting for page loading

#             #Shared step : When user visit My leave days
#             When user forced click on element ".bars"
#             And user click on anchor with link "app/main/absence-day"
#             And user forced click on element ".bars"
#             Then user is navigated to page "app/main/absence-day"
#             Then element ".header" should be visible
#             And it's text should contains 'My off days'
#             #Shared step : Then waiting for page loading
#             Then waiting for page loading

                #Shared step : Then waiting for page loading
#             Then waiting for page loading

#             #Shared step : And user send request
#             # When set element ".cal-day-cell.cal-future span:first-child:not(.cal-day-badge):first" as alias "dayInFuture"
#             When set element ".cal-day-cell.cal-future:not(.all-day-absence):not(morning-absence):not(.afternoon-absence):not(.custom-absence-time):not(.back-red) :first" as alias "dayInFuture"
#             When user click on element by alias "@dayInFuture"
#             And user click on element has text "Send leave request"
#             Then element ".mat-dialog-container h1" should be visible
#             And it's text should contains "Submit leave request"
#             When user forced click on element has text "Absence Type"
#             And user click on element ".mat-select-panel .mat-option:first-child"
#             And user value "Test request leave day!" into input with label "Reason"

#             Then user click on element has text "Save"
#             And user is able to see element by alias "@dayInFuture"
#             Then element by alias "@dayInFuture" should contains "Approved"




#         Examples: NewDataSet
#             | url                              | username                | password |
#             | http://dev.timesheet.nccsoft.vn/ | trang.auto@gmail.com | 123qwe   |


#     # #     ###
#         @TEST_CASE_1.3 @STATE_Design
#         Scenario Outline: Verify user able to cancel request leave on current day
#         # Shared step: Given user login ERP Timesheet
#         Given user visit page "<url>"
#         And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
#         And user enter "<password>" into field by placeholder "Password"
#         And user click on element "button" contains "Log in"

#         #Shared step : Then waiting for page loading
#         Then waiting for page loading

#         #     #Shared step : When user visit My leave days
#         When user forced click on element ".bars"
#         And user click on anchor with link "app/main/absence-day"
#         And user forced click on element ".bars"
#         Then user is navigated to page "app/main/absence-day"
#         Then element ".header" should be visible
#         And it's text should contains 'My off days'

#         #Shared step : Then waiting for page loading
#         Then waiting for page loading

#         #Shared step : When user cancel leave day
#         When set element "mwl-calendar-month-cell.cal-today:contains('Approved')" as alias "today"
#         When user click on element by alias "@today"
#         # When user click on element "mwl-calendar-month-cell.cal-today"
#         Then element ".mat-dialog-container h1" should be visible
#         And it's text should contains "Details Of"
#         When user click on element has text "Cancel"
#         Then user is able to see element by alias "@today"
#         And element by alias "@today" should contains "Reject"




#     Examples: NewDataSet
#             | url                              | username                | password |
#             | http://dev.timesheet.nccsoft.vn/ | trang.auto@gmail.com | 123qwe   |


#     # #     ###
#         @TEST_CASE_1.3 @STATE_Design
#         Scenario Outline: Verify user unable to cancel request leave on past day
#         # Shared step: Given user login ERP Timesheet
#         Given user visit page "<url>"
#         And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
#         And user enter "<password>" into field by placeholder "Password"
#         And user click on element "button" contains "Log in"

#         #Shared step : Then waiting for page loading
#         Then waiting for page loading

#         #Shared step : When user visit My leave days
#         When user forced click on element ".bars"
#         And user click on anchor with link "app/main/absence-day"
#         And user forced click on element ".bars"
#         Then user is navigated to page "app/main/absence-day"
#         Then element ".header" should be visible
#         And it's text should contains 'My off days'

#         #Shared step : Then waiting for page loading
#         Then waiting for page loading

#         #Shared step : When user cancel request
#         When user click on element ".cal-day-cell.cal-past:contains('Approved'):first"
#         Then element ".mat-dialog-container h1" should be visible
#         And it's text should contains "Details Of"
#         Then element ".reject" should not be exist
#         And user click on element has text "Close"

#          Examples: NewDataSet
#             | url                              | username                | password |
#             | http://dev.timesheet.nccsoft.vn/ | tien.nguyenhuu@ncc.asia | 123qwe   |


#         # ###
#         @TEST_CASE_1.3 @STATE_Design
#         Scenario Outline: Verify user able to cancel request leave on future day
#         # Shared step: Given user login ERP Timesheet
#         Given user visit page "<url>"
#         And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
#         And user enter "<password>" into field by placeholder "Password"
#         And user click on element "button" contains "Log in"

#         #Shared step : Then waiting for page loading
#         Then waiting for page loading

#         #Shared step : When user visit My leave days
#         When user forced click on element ".bars"
#         And user click on anchor with link "app/main/absence-day"
#         And user forced click on element ".bars"
#         Then user is navigated to page "app/main/absence-day"
#         Then element ".header" should be visible
#         And it's text should contains 'My off days'

#         #Shared step : Then waiting for page loading
#         Then waiting for page loading

#         #Shared step : When user cancel request
#         When set element "mwl-calendar-month-cell.cal-future:contains('Approved'):first" as alias "dayInFuture"
#         When user click on element by alias "@dayInFuture"
#         Then element ".mat-dialog-container h1" should be visible
#         And it's text should contains "Details Of"
#         And user click on element has text "Cancel"
#         Then user is able to see element by alias "@dayInFuture"
#         And element by alias "@dayInFuture" should contains "Rejected"
#         # And user reload page



#     Examples: NewDataSet
#             | url                              | username                | password |
#             | http://dev.timesheet.nccsoft.vn/ | tien.nguyenhuu@ncc.asia | 123qwe   |


#     # ###

#     @TEST_CASE_1.3 @STATE_Design
#     Scenario Outline: Verify user unable to send request leave on day had another request in status approved
#         # Shared step: Given user login ERP Timesheet
#         Given user visit page "<url>"
#         And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
#         And user enter "<password>" into field by placeholder "Password"
#         And user click on element "button" contains "Log in"

#         #Shared step : Then waiting for page loading
#         Then waiting for page loading

#         #Shared step : When user visit My leave days page
#         When user forced click on element ".bars"
#         And user click on anchor with link "app/main/absence-day"
#         And user forced click on element ".bars"
#         Then user is navigated to page "app/main/absence-day"
#         Then element ".header" should be visible
#         And it's text should contains 'My off days'

#         #Shared step : Then waiting for page loading
#         Then waiting for page loading

#         #Shared step : When user send request
#         When set element ".cal-day-cell:contains('Approved'):last" as alias "dayHadRequest"
#         When user click on element by alias "@dayHadRequest"
#         Then element ".mat-dialog-container h1" should be visible
#         And it's text should contains "Details Of"
#         Then user click on element has text "Close"
#         Then user is able to see element by alias "@dayHadRequest"
#         And element by alias "@dayHadRequest" should contains "Approved"



#        Examples: NewDataSet
#             | url                              | username                | password |
#             | http://dev.timesheet.nccsoft.vn/ | tien.nguyenhuu@ncc.asia | 123qwe   |


# # ###

#         @TEST_CASE_1.3 @STATE_Design
#         Scenario Outline: Verify user able to send request leave on day had another request in status rejected
#         # Shared step: Given user login ERP Timesheet
#         Given user visit page "<url>"
#         And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
#         And user enter "<password>" into field by placeholder "Password"
#         And user click on element "button" contains "Log in"

#         #Shared step : Then waiting for page loading
#         Then waiting for page loading

#         #Shared step : When user visit My leave days page
#         When user forced click on element ".bars"
#         And user click on anchor with link "app/main/absence-day"
#         And user forced click on element ".bars"
#         Then user is navigated to page "app/main/absence-day"
#         Then element ".header" should be visible
#         And it's text should contains 'My off days'

#         #Shared step : Then waiting for page loading
#         Then waiting for page loading

#         #Shared step : When user send leave day
#         When set element "mwl-calendar-month-cell:contains('Rejected'):last" as alias "dayHadRequest"
#         When user click on element by alias "@dayHadRequest"
#         # When user click on element ".cal-day-cell" contains ".day-off-state-reject" and not contains "Off"
#         And user click on element has text "Send leave request"
#         Then element ".mat-dialog-container h1" should be visible
#         And it's text should contains "Submit leave request"
#         When user forced click on element has text "Absence Type"
#         And user click on element ".mat-select-panel .mat-option:first-child"
#         # Then element "mat-select" should be not visible
#         And user value "Test request leave day!" into input with label "Reason"

#         Then user click on element has text "Save"
#         Then user is able to see element by alias "@dayHadRequest"
#         And element by alias "@dayHadRequest" should contains "Approved"

#               Examples: NewDataSet
#             | url                              | username                | password |
#             | http://dev.timesheet.nccsoft.vn/ | tien.nguyenhuu@ncc.asia | 123qwe   |


#     # # ###
#         @TEST_CASE_1.3 @STATE_Design
#         Scenario Outline: Verify PM reject request
#         # Shared step: Given user login ERP Timesheet
#         Given user visit page "<url>"
#         And user enter "<username>" into field "input[name='userNameOrEmailAddress']"
#         And user enter "<password>" into field by placeholder "Password"
#         And user click on element "button" contains "Log in"

#         #Shared step : Then waiting for page loading
#         Then waiting for page loading

#         #Shared step : When user visit My leave days
#         When user forced click on element ".bars"
#         And user click on anchor with link "off-day-project" and contains "Manage team working calendar"
#         And user forced click on element ".bars"
#         Then waiting for page loading
#         Then element ".header h2" should be visible
#         And it's text should contains 'Manage team working calendar'

#         #Shared step : Then waiting for page loading
#         Then waiting for page loading

#         #Shared step : When user reject request
#         When user click on element ".cal-has-events:not(.back-red):last"
#         Then element ".mat-dialog-container h4" should be exist
#         And it's text should contains "List user"
#         Then user click on element ".reject-button:first"
#         Then element ".approve-button" should be exist


#             Examples: NewDataSet
#             | url                              | username                | password |
#             | http://dev.timesheet.nccsoft.vn/ | duong.nguyen | 123qwe   |


###

####

# 1. Request ngày hiện tại  ok
# 2. Request ngày tương lai ok
# 3. Request ngày quá khứ ok
# 4. Cancel request tại các ngày hiện tại/tương lai/ quá khứ ok
# 5. Gửi request leave vào ngày đang có request khác ở trạng thái approved ok
# 6. Gửi request leave vào ngày có request khác ở trạng thái rejected ok
# 7. request vào ngày nghỉ ok
# 8. PM reject request ok
# 9. PM reject request/ employee sent another request (approved) > PM approved the rejected request above


# @TEST_CASE_2 @STATE_Design
# Scenario Outline: Verify login
#     # Shared step: Given user login ERP Project
#     Given user visit page "http://uat.timesheet.nccsoft.vn/"
#     And user enter "<username>" into field by placeholder "User name or email"
#     And user enter "<password>" into field by placeholder "Password"
#     Then user click on element "button" contains "Log in"

#     #Shared step : When user visit My leave days/onsite
#     Then user forced click on element ".bars"
#     Then user click on anchor with link "app/main/absence-day"
#     Then user forced click on element ".bars"
#     # @TEST_CASE_2_1 @STATE_Design
#         #Shared step : When user log leave day
#         And user click on element has text "14"
#         And user click on element has text "Send onsite request"
#         # And user click on element by id "mat-select-5"
#         # And user click on element by id "mat-option-31"
#         And user value "Test request leave day!" into input with label "Note"

#         And user click on element has text "Save"
#     # @TEST_CASE_2_2 @STATE_Design
#     #     And user click on element has text "14"
#     #     And user click on element has text "Close"

#     #Shared step : When user visit My Timesheet
#     Then user forced click on element ".bars"
#     Then user click on anchor with link "app/main/mytimesheets"
#     Then user forced click on element ".bars"

#     #Shared step : When user log timesheet
#     Then user click on element by id "mat-tab-label-0-8"
#     Then user click on element ".mat-icon" contains "add"
#     And  user click on element "[name=project]"
#     And  user click on element has text " ERP - "
#     And  user enter "Lam task Frontend" into field by name "[name=note]"
#     And  user enter "8" into field by name "[name=workingTime]"
#     And user click on element has text "Save"


#     Examples: NewDataSet
#         | username | password |
#         | tien.nguyenhuu@ncc.asia  | 123qwe  |


#  ###
#     @TEST_CASE_3 @STATE_Design
#     Scenario Outline: Verify login
#     # Shared step: Given user login ERP Project
#     Given user visit page "http://uat.timesheet.nccsoft.vn/"
#     And user enter "<username>" into field by placeholder "User name or email"
#     And user enter "<password>" into field by placeholder "Password"
#     Then user click on element "button" contains "Log in"

#     #Shared step : When user visit My leave days/onsite
#     Then user forced click on element ".bars"
#     Then user click on anchor with link "app/main/absence-day"
#     Then user forced click on element ".bars"

#     #Shared step : When user log leave day
#     And user click on element has text "15"
#     And user click on element has text "Send remote request"
#     And user value "Test request leave day!" into input with label "Note"

#     And user click on element has text "Save"


#     #Shared step : When user visit My Timesheet
#     Then user forced click on element ".bars"
#     Then user click on anchor with link "app/main/mytimesheets"
#     Then user forced click on element ".bars"

#     #Shared step : When user log timesheet
#     Then user click on element by id "mat-tab-label-0-9"
#     Then user click on element ".mat-icon" contains "add"
#     And  user click on element "[name=project]"
#     And  user click on element has text " ERP - "
#     And  user enter "Lam task Frontend" into field by name "[name=note]"
#     And  user enter "8" into field by name "[name=workingTime]"
#     And user click on element has text "Save"


#     Examples: NewDataSet
#         | username | password |
#         | tien.nguyenhuu@ncc.asia  | 123qwe  |