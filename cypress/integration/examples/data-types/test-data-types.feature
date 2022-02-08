Feature: Test Data type

  # ###########
  #    Ref: https://ops.nccsoft.vn/DefaultCollection/a5caa4a9-4c73-48d6-9b3c-d2764fe3e9ff/_workitems/edit/26119
  # #
  #
  Scenario Outline: Verify that user able to delete sao do
    Given user visit page "https://www.google.com/"
    Then element ".FPdoLc>center>input[name='btnK']" should be visible
    And element ".FPdoLc>center>input[name='btnK']" should have class "gNO89b"
    And element ".FPdoLc>center>input[name='btnK']" should have prop 'value'
    And it's text should be not null
    And it's val should to contain "Tìm trên Google"
    And it's prop 'value' should be not to contain "Search"
    And it's attr 'value' should be not null
    
    # And it's value should to include Login 'Tìm trên Google'

    Examples: NewDataSet

      | username | password | saoDoName   |
      | admindev | 123qwe   | SaoDoEdit |

