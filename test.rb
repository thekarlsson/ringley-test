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

  def test_on
    reminders = ["0066S due date 2016-02-01",
                 "0250S due date 2016-01-23"]
    assert_equal reminders, @reminder.on(Date.strptime("1 Jan", "%d %b"), @estates)
  end
end
