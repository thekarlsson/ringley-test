class Estate
  require "date"

  attr_reader(:code, :charge_period)

  def initialize(code, charge_period, due_dates)
    @code = code
    @charge_period = charge_period
    @due_dates = due_dates.map { |e| Date.strptime(e, "%d %b") }
  end

  def next_due_date(date)
    @due_dates.each do |due_date|
      if due_date >= date
        return due_date
      end
    end

    return @due_dates.first.next_year
  end
end
