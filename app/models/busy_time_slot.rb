class BusyTimeSlot < ApplicationRecord
  WEEK_LENGTH = 7

  scope :recurring, -> { where(recurring: true) }

  scope :this_week, lambda {
    where(
      'starts_at >= :week_start AND ends_at <= :week_end',
      week_start: Date.today.beginning_of_week.beginning_of_day,
      week_end: Date.today.end_of_week.end_of_day
    )
  }
  scope :weeks_from_now, lambda { |number_of_weeks = 1|
    day_next_week = Date.today + number_of_weeks.weeks

    where(
      'starts_at >= :week_start AND ends_at <= :week_end',
      week_start: day_next_week.beginning_of_week.beginning_of_day,
      week_end: day_next_week.end_of_week.end_of_day
    )
  }

  scope :whole_week_for_datetime, lambda { |datetime|
    where(
      'starts_at >= :week_start AND ends_at <= :week_end',
      week_start: datetime.beginning_of_week.beginning_of_day,
      week_end: datetime.end_of_week.end_of_day
    )
  }

  class << self
    def display_schedule(week_number = 0)
      slots = weeks_from_now(week_number)

      if slots.count < WEEK_LENGTH
        recurring_slots = whole_week_for_datetime(recurring.last.starts_at).recurring
        slots += recurring_slots
      end

      slots.sort_by(&:starts_at)
           .group_by { |slot| (slot.starts_at.wday) }
             .each do |day, slots|
               puts "#{day} =>" + slots.map { |slot| "|#{slot.starts_at.strftime('%T')} - #{slot.ends_at.strftime('%T')}|"}.join
             end

      nil
    end
  end
end
