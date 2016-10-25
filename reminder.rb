class Reminder
  def initialize(rules)
    @rules = rules
  end

  def on(date, estates)
    estates_in_need_of_reminding = []

    estates.each do |estate|
      due_date_offset = date.next_month(@rules[estate.charge_period.to_sym])
      next_due_date = estate.next_due_date(date)

      if due_date_offset >= next_due_date && date <= next_due_date
        estates_in_need_of_reminding << "#{estate.code} due date #{next_due_date}"
      end
    end
    
    return estates_in_need_of_reminding
  end
end
