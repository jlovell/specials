class RestaurantDecorator
  attr_reader :restaurant
  delegate :id, to: :restaurant
  def initialize(restaurant)
    @restaurant = restaurant
  end

  def google_link
    "https://www.google.com/search?q=#{name.tr(' ', '+')}+Chicago"
  end

  def address_search_link
    "https://www.google.com/maps/place/#{address.tr(' ', '+')}"
  end

  # unused and not working
  def maps_marker
    "&markers=color:green%7C#{place[:latitude]},#{place[:longitude]}"
  end

  def method_missing(method, *args, &block)
    restaurant.send(method, *args, &block)
  end
end
