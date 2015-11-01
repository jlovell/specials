class Special < ActiveRecord::Base
  self.inheritance_column = nil

  belongs_to :restaurant

  validates :day, presence: true, inclusion: { in: (0..6) }

  scope :food,  -> { where(type: "food")  }
  scope :drink, -> { where(type: "drink") }

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
end
