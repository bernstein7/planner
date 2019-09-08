# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# This week I work form 10:00 to 18:00
day_this_week = Date.today
(day_this_week.beginning_of_week..day_this_week.end_of_week).map do |day|
  BusyTimeSlot.create(
    starts_at: day.beginning_of_day,
    ends_at: day.beginning_of_day + 10.hours
  )
  BusyTimeSlot.create(
    starts_at: day.beginning_of_day + 18.hours,
    ends_at: day.end_of_day
  )
end

# Next week I plan working form 11:00 to 19:00
day_next_week = Date.today + 1.week
(day_next_week.beginning_of_week..day_next_week.end_of_week).map do |day|
  BusyTimeSlot.create(
    starts_at: day.beginning_of_day,
    ends_at: day.beginning_of_day + 11.hours
  )
  BusyTimeSlot.create(
    starts_at: day.beginning_of_day + 19.hours,
    ends_at: day.end_of_day
  )
end

# And there are some already accepted jobs for next week

job1 = BusyTimeSlot.create(
  starts_at: Date.today.next_week.advance(days: 0) + 11.hours,
  ends_at: Date.today.next_week.advance(days: 0) + 15.hours,
  recurring: false
)

job2 = BusyTimeSlot.create(
  starts_at: Date.today.next_week.advance(days: 3) + 11.hours,
  ends_at: Date.today.next_week.advance(days: 3) + 15.hours,
  recurring: false
)

job2 = BusyTimeSlot.create(
  starts_at: Date.today.next_week.advance(days: 4) + 15.hours,
  ends_at: Date.today.next_week.advance(days: 4) + 19.hours,
  recurring: false
)