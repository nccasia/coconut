@TEST_PROJECT_NCC-ERP @TEST_PLAN_26040 @TEST_SUITE_26108 @TEST_SUITE_TYPE_staticTestSuite
Feature: Project demo
  Ref: https://ops.nccsoft.vn/DefaultCollection/a5caa4a9-4c73-48d6-9b3c-d2764fe3e9ff/_workitems/edit/26108


  # ###########
  #    Ref: https://ops.nccsoft.vn/DefaultCollection/a5caa4a9-4c73-48d6-9b3c-d2764fe3e9ff/_workitems/edit/26111
  # #
  #
  @TEST_CASE_26111 @STATE_Design
  Scenario Outline: Verify admin is able to create Sao do
    # Shared step: Given user login ERP Project - 26110
    Given user visit page "http://project.dev.nccsoft.vn/"
    And user enter "<username>" into field by placeholder "User name or email"
    And user enter "<password>" into field by placeholder "Password"
    Then user click on element by class "btn-block"
    # ---
    # Shared step: When user visit sao do page - 26112
    And user click on anchor with link "/app/sao-do"
    # ---
    # Shared step: And user is able to create new sao do - 26113
    Then user click on element has text " Create "
    And user enter "<saoDoName>" into field by name "name"
    And user enter "<saoDoStartTime>" into field by name "startTime"
    And user enter "<saoDoEndTime>" into field by name "endTime"
    Then  user click on element has text "Save"
    # ---
    # Shared step: Then user able to see sao do search result - 26114
    When user enter "<saoDoName>" into field by name "keyword"
    And user click on element by class "fa-search"

    Examples: NewDataSet

      | username | password | saoDoName | saoDoStartTime | saoDoEndTime |
      | admindev | 123qwe   | CreateSD1| 27/01/2022     |              |
  # ###########
  #    Ref: https://ops.nccsoft.vn/DefaultCollection/a5caa4a9-4c73-48d6-9b3c-d2764fe3e9ff/_workitems/edit/26115
  # #
  #
  @TEST_CASE_26115 @STATE_Design
  Scenario Outline: Verify admin is able to edit Sao do
    # Shared step: Given user login ERP Project - 26110
    Given user visit page "http://project.dev.nccsoft.vn/"
    And user enter "<username>" into field by placeholder "User name or email"
    And user enter "<password>" into field by placeholder "Password"
    Then user click on element by class "btn-block"
    # ---
    # Shared step: When user visit sao do page - 26112
    And user click on anchor with link "/app/sao-do"
    # ---
    # Shared step: Then user able to see sao do search result - 26114
    When user enter "<saoDoName>" into field by name "keyword"
    And user click on element by class "fa-search"
    # ---
    # Shared step: When user edit Sao do - 26116
    And user click on element has text "Edit"
    And user clear field by name 'name'
    And user enter "SaoDoEdit" into field by name "name"
    And user clear field by name "startTime"
    And user enter "<saoDoStartTime>" into field by name "startTime"
    And user clear field by name "endTime"
    And user enter "<saoDoEndTime>" into field by name "endTime"
    Then user click on element has text "Save"
    # ---
    # Shared step: Then user able to see sao do search result - 26114
    And user clear field by name 'keyword'
    When user enter "SaoDoEdit" into field by name "keyword"
    And user click on element by class "fa-search"

    Examples: NewDataSet

      | username | password | saoDoName | saoDoStartTime | saoDoEndTime |
      | admindev | 123qwe   | CreateSD1 | 27/01/2022     |              |
  # ###########
  #    Ref: https://ops.nccsoft.vn/DefaultCollection/a5caa4a9-4c73-48d6-9b3c-d2764fe3e9ff/_workitems/edit/26119
  # #
  #
  @TEST_CASE_26119 @STATE_Design
  Scenario Outline: Verify that user able to delete sao do
    # Shared step: Given user login ERP Project - 26110
    Given user visit page "http://project.dev.nccsoft.vn/"
    And user enter "<username>" into field by placeholder "User name or email"
    And user enter "<password>" into field by placeholder "Password"
    Then user click on element by class "btn-block"
    # ---
    # Shared step: When user visit sao do page - 26112
    And user click on anchor with link "/app/sao-do"
    # ---
    # Shared step: Then user able to see sao do search result - 26114
    When user enter "<saoDoName>" into field by name "keyword"
    And user click on element by class "fa-search"
    # ---
    # Shared step: When user delete sao do - 26117
    And user click on element has text "Delete"
    Then user click on element has text "Yes"
    # ---
    # Shared step: Then user able to see sao do search result - 26114
    And user clear field by name 'keyword'
    When user enter "<saoDoName>" into field by name "keyword"
    And user click on element by class "fa-search"

    Examples: NewDataSet

      | username | password | saoDoName   |
      | admindev | 123qwe   | SaoDoEdit |

