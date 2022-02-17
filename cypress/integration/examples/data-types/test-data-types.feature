Feature: Test Data type

  # ###########
  #    Ref: https://ops.nccsoft.vn/DefaultCollection/a5caa4a9-4c73-48d6-9b3c-d2764fe3e9ff/_workitems/edit/26119
  # #
  #
  Scenario Outline: Verify that user able to delete sao do
    # Given user visit page "https://www.google.com/"
    # Then element ".gb_1" should have attr 'href'
    # Then element ".FPdoLc>center>input[name='btnK']" should be visible
    # And element ".FPdoLc>center>input[name='btnK']" should have class "gNO89b"
    # And element ".FPdoLc>center>input[name='btnK']" should have prop 'value'
    # And element ".FPdoLc>center>input[name='btnK']" should have prop 'value' 'Tìm trên Google'
    # And it's text should be not null
    # And it's val should to contain "Tìm trên Google"
    # And it's prop 'value' should be not to contain "Search"
    # And it's attr 'value' should be not null
    # Then element ".gNO89b" should be visible
    # And it should have class "gNO89b"
    # Then element ".gb_1" should have attr 'href' 'https://accounts.google'
    # Given user visit page "http://127.0.0.1:5500/index.html"
    # Then element "#btn_hello" should be visible
    # Then user reload page
    # Then user take screenshot
    # Then user hover element "#btn_hello" contains "hello"
    # Then user focus element "#btn_hello" contains "hello"
    # Then user blur element "#btn_hello" contains "hello"
    # Then user select option "Mercedes" of element "select" contains "Mercedes"
    # Then user check element "form" contains "Minh"
    # Then user select file "banh-kem-dua-hau.jpg" into "input[type=file]"
    # Then user uncheck element "#vehicle1" contains "Bike"
    # Then user right click on element "#btn_hello" contains "hello"
    # Then user double click on element "#btn_hello" contains "hello"
    # Then user submit element "#sb"

    Examples: NewDataSet

      | username | password | saoDoName   |
      | admindev | 123qwe   | SaoDoEdit |

