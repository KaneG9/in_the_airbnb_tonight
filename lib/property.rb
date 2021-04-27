
class Property

  attr_reader :postcode, :title, :description, :price
  
  def initialize(postcode:, title:, description:, price:)
    # @id = id
    @postcode = postcode
    @title = title
    @description = description
    @price = price
  end

  #do the database stuff boyo

end