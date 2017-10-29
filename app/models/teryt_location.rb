class TerytLocation < ApplicationRecord
  def self.find_address(_address_string)
    # adress_string = address_string.to_can.downcase
    [42, 24]
  end

  def self.clean(address)
    result = address
    %w[aleja ulica osiedle plac rondo al ul os pl].each do |c|
      result = result.gsub(c, '')
    end
    result.parameterize.gsub('-', ' ')
  end
end
