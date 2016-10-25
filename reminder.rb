class Reminder
  def initialize(rules)
    @rules = rules
  end

  def on(date, estates)
    estates_in_need_of_reminding = []

    estates.each do |estate|
      due_date_offset = date.next_month(@rules[estate.charge_period.to_sym])

      estate.due_dates.each do |due_date|
        if due_date_offset >= due_date && date <= due_date
          estates_in_need_of_reminding << "#{estate.code} due date #{due_date}"
        end
      end
    end
    return estates_in_need_of_reminding
  end
end
