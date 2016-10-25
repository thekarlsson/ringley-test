class Estate
  require "date"
  
  attr_reader(:code, :charge_period, :due_dates)

  def initialize(code, charge_period, due_dates)
    @code = code
    @charge_period = charge_period
    @due_dates = due_dates.map { |e| Date.strptime(e, "%d %b") }
  end
end
