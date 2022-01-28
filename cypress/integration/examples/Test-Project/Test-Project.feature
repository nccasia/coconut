Feature:  Project Testing Feature
    Scenario Outline: Vertify that user able to login this system
        # Shared step: Given "@user" logins
        Given user visit page "<url>"
        And user enter "<username>" into field with placeholder "User name or email"
        And user enter "<password>" into field with placeholder "Password"
        Then user click on button with class "btn-block"

        #Share step: Visit page Sao do
        And user visit to sub page "/app/sao-do"

        #Share step: Create Sao do
        And user is able to click on button " Create "
        # Then popup create is displayed
        # And user must fill in required  field
        And user enter "<saoDoName>" into filed with name "name"
        And user enter "<saoDoStartTime>" into filed with name "startTime"
        And user enter "<saoDoEndTime>" into filed with name "endTime"
        Then user is able to click on button "Save"

        #Share step search
        And user enter "<saoDoName>" into filed with name "keyword"
        Then user click on button with class "fa-search"

        #Share step: Edit Sao do
        And user is able to click on button "Edit"
        And user clear and update "Edit Sao Do" into filed with name "name"
        And user clear and update "<saoDoStartTime>" into filed with name "startTime"
        And user clear and update "<saoDoEndTime>" into filed with name "endTime"
        Then user is able to click on button "Save"

        #Share step search
        And user clear and update "Edit" into filed with name "keyword"
        Then user click on button with class "fa-search"

        #Share step: Delete Saodo
        And user is able to click on button "Delete"
        # Then dialog delete is displayed
        Then user is able to click on button "Yes"
        #Share step search
        And user clear and update "" into filed with name "keyword"
        Then user click on button with class "fa-search"

        # Given user visit page '<url>'
        Examples:
            | url                            | username | password | saoDoName       | saoDoStartTime | saoDoEndTime |
            | http://project.dev.nccsoft.vn/ | admindev | 123qwe   | Test Auto | 27/01/2022     |              |

