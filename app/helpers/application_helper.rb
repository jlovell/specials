module ApplicationHelper

  def day_name(day)
    case day
    when Time, Date, DateTime
      Date::DAYNAMES[day.wday]
    when Integer
      Date::DAYNAMES[day]
    when /\A\d\z/
      Date::DAYNAMES[day.to_i]
    when Symbol, String
      day.to_s.titleize
    else
      'Today'
    end
  end
end
