require_relative "reminder"
require_relative "estate"

require "date"
require "minitest/autorun"

class TestReminder < Minitest::Test
  def setup
    @reminder = Reminder.new({quarterly: 1, biannually: 2})
    @estates = []
    @estates << Estate.new("0066S", "quarterly", ["1 Feb", "3 May", "1 Aug", "5 Nov"])
    @estates << Estate.new("0123S", "quarterly", ["28 Feb", "31 May", "31 Aug", "30 Nov"])
    @estates << Estate.new("0250S", "biannually", ["23 Jan", "22 Jun"])
  end

  def test_simple
    reminders = ["0066S due date 2009-02-01",
                 "0250S due date 2009-01-23"]
    assert_equal reminders, @reminder.on(Date.strptime("1 Jan 2009", "%d %b %Y"), @estates)
  end

  def test_empty
    reminders = []
    assert_equal reminders, @reminder.on(Date.strptime("15 Mar 1999", "%d %b %Y"), @estates)
  end

  def test_last_day_of_month
    reminders = ["0066S due date 2002-05-03",
                 "0123S due date 2002-05-31",
                 "0250S due date 2002-06-22"]
    assert_equal reminders, @reminder.on(Date.strptime("30 Apr 2002", "%d %b %Y"), @estates)
  end

  def test_year_rollover
    reminders = ["0250S due date 2007-01-23"]
    assert_equal reminders, @reminder.on(Date.strptime("24 Dec 2006", "%d %b %Y"), @estates)
  end
end
