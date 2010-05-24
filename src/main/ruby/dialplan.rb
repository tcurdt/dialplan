class String
  def starts_with?(prefix)
    prefix = prefix.to_s
    self[0, prefix.length] == prefix
  end
  def blank?
    self.nil? || self.empty?
  end
end


module DialPlan

require 'yaml'

class DialPlan

  class CountryPlan

    def initialize(dialplan, code)
      @dialplan = dialplan
      @code = code
    end

    def internationalizeNumber(number)
      return nil if number.blank?
      
      entry = @dialplan[@code]
      iprefix = entry['iprefix']
      nprefix = entry['nprefix']
      
      if number.starts_with?('+')
        country = @dialplan.code_from_number(number)

        if country != nil
          numberWithoutCountry = number[country.length..-1]
          national = "(#{nprefix})"

          if numberWithoutCountry.starts_with?(national)            
              number = "#{country}#{numberWithoutCountry[national.length..-1]}"
          end
          
          return number.gsub(/[^+0123456789]/, '')
        end

        # unknown country code
        return nil
      end
      
      if number.starts_with?(iprefix)
        # dialing out of the country        
        numberWithCountry = "+#{number[iprefix.length..-1]}"

        # check international number based on the country code
        if @dialplan.code_from_number(numberWithCountry)
          return numberWithCountry.gsub(/[^+0123456789]/, '')
        end
        
        # unknown country code
        return nil
      end

      if number.starts_with?(nprefix)
        # dialing inside the country
        number = "#{@code}#{number[nprefix.length..-1]}"
        return number.gsub(/[^+0123456789]/, '')
      end

      number = "#{@code}#{number}"
      return number.gsub(/[^+0123456789]/, '')      
    end
  end

  def initialize(path)
    @codes = YAML::load_file(path)
  end

  def country(code)
    CountryPlan.new(self, code)
  end

  def code_from_number(number)
    4.downto(1) do |i|
      part = @codes[number[0..i]]
      return part if part
    end
    nil
  end

  def [](i)
    @codes[i]
  end
end

end