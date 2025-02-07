require "icalendar"

def read_calendar(input)
    #calendar_file = File.open(calendar_filename)
    #events = Icalendar::Event.parse(calendar_file)
    events = Icalendar::Event.parse(input)
    hash = {}
    counter = 0

    # loop through the events in the calendars
    # and map the values you want into a variable and then return it:
    events.each do |event|
      hash[counter] = {
        "summary" => event.summary,
        "dtstart" => event.dtstart,
        "dtend" => event.dtend,
        "description" => event.description
      }
      counter += 1
    end

    return hash
end
