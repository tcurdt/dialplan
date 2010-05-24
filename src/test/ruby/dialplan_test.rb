$:.unshift File.expand_path("../../main/ruby")
require 'test_helper'
require 'dialplan'

class PhoneNumberTest < Test::Unit::TestCase

  def test_number_conversion
    
    path = File.expand_path(File.dirname(__FILE__) + '/../../../' + 'dialplan.yaml')

    plan = DialPlan::DialPlan.new(path)

    country = plan.country('+49')
    
    assert_equal '+491111', country.internationalizeNumber('1111')
    assert_equal '+49179', country.internationalizeNumber('0179')
    assert_equal '+49179', country.internationalizeNumber('+49179')
    assert_equal '+49179', country.internationalizeNumber('0049179')
    assert_equal '+15551234', country.internationalizeNumber('0015551234')
    assert_equal '+15551234', country.internationalizeNumber('+15551234')
    
    country = plan.country('+1')

    assert_equal '+49179', country.internationalizeNumber('01149179')
    assert_equal '+49179', country.internationalizeNumber('+49179')
    assert_equal '+15551234', country.internationalizeNumber('5551234')
    
  end

end