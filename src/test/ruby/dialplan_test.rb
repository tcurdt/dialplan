require File.expand_path(File.dirname(__FILE__) + '/test_helper')

require 'dialingplan'

class PhoneNumberTest < Test::Unit::TestCase

  def setup
  end

  def test_should_work
    path = File.expand_path(File.dirname(__FILE__) + '/../../../' + 'countries.yaml')

    # [plan internationalizeNumber:@"1111" forCode:@"+49"]
    # [plan internationalizeNumber:@"0179" forCode:@"+49"]
    # [plan internationalizeNumber:@"+49179" forCode:@"+49"]
    # [plan internationalizeNumber:@"0049179" forCode:@"+49"]
    # [plan internationalizeNumber:@"0015551234" forCode:@"+49"]
    # [plan internationalizeNumber:@"+15551234" forCode:@"+49"]
    # [plan internationalizeNumber:@"01149179" forCode:@"+1"]
    # [plan internationalizeNumber:@"+49179" forCode:@"+1"]
    # [plan internationalizeNumber:@"5551234" forCode:@"+1"]
    
  end

end