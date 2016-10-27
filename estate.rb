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
      due_date = set_year(due_date, date.year)

      if due_date >= date
        return due_date
      end
    end

    return set_year(@due_dates.first, date.next_year.year)
  end

  private

  def set_year(date, year)
    Date.new(year, date.month, date.day)
  end
end
