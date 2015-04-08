class Restaurant < ActiveRecord::Base
  has_many :specials, dependent: :destroy
  geocoded_by :address
  before_validation :normalize_attributes
  after_validation :geocode, :if => :address_changed?

  accepts_nested_attributes_for :specials,
    reject_if: proc { |attrs| attrs.values_at(:food, :drink).all?(&:blank?) }

  def normalize_attributes
    self.address &&= address.tr('.','').titleize
    self.address += ", Chicago, IL" unless self.address =~ /chicago/i
  end

  def decorate
    ::RestaurantDecorator.new(self)
  end
end
