class Reminder
  def initialize(rules)
    @rules = rules
  end

  def on(date, estates)
    estates_in_need_of_reminding = []

    estates.each do |estate|
      due_date_offset = offset_date(date, @rules[estate.charge_period.to_sym])
      next_due_date = estate.next_due_date(date)

      if due_date_offset >= next_due_date
        estates_in_need_of_reminding << "#{estate.code} due date #{next_due_date}"
      end
    end

    return estates_in_need_of_reminding
  end

  private

  def last_day_of_month?(date)
    date.next_day.day == 1
  end

  def offset_date(date, offset)
    unless last_day_of_month?(date)
      date.next_month(offset)
    else
      date.next_day.next_month(offset).prev_day
    end
  end
end
