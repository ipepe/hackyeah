class TerytLocation < ApplicationRecord
  def self.find_address(_address_string)
    # adress_string = address_string.to_can.downcase
    [42, 24]
  end

  def self.clean(address)
    result = address
    %w[aleja ulica osiedle plac rondo].each do |c|
      result = result.gsub(c, '')
    end
    result = result.parameterize.gsub(/[-\/.]/, ' ')
    %w[al ul os pl].each do |c|
      if result.start_with?(c+' ')
        result = result[3..-1]
      end
      result.gsub(/\A#{c} /, '')
    end
    result
  end
end
