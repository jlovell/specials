class Special < ActiveRecord::Base
  belongs_to :restaurant
  before_save :normalize_attributes

  validates :day, presence: true, inclusion: { in: (0..6) }

  def self.for(day)
    case day
    when Time, Date, DateTime
      where(day: day.wday)
    when Symbol, String
      where(day: Date::DAYNAMES.index(day.to_s.titleize))
    when Integer
      where(day: day)
    else
      raise ArgumentError, "Unrecognized day of the week"
    end
  end

  def normalize_attributes
    self.food  = food.presence.try(:titleize)
    self.drink = drink.presence.try(:titleize)
  end
end
