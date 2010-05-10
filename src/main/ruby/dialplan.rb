module DialPlan

require 'yaml'

class DialPlan

  def initialize(path)
    @countries = YAML::load_file(path)
  end

end

end