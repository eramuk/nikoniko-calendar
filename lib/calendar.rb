class Calendar
  def self.week(num=1)
    weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    start_day = (num.week.ago + 1.day).to_datetime
    end_day = Time.current.to_datetime

    (start_day..end_day).map do |date|
      {
        "date" => date.to_date,
        "weekday" => weekdays[date.wday]
      }
    end
  end
end