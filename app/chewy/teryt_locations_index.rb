class TerytLocationsIndex < Chewy::Index
  define_type TerytLocation.all
  def self.find_address(address)
    TerytLocationsIndex.query(match: {street: {query: address, fuzziness: "AUTO", operator: 'and'}}).first
  end
end

