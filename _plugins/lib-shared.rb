
# Convert a date string to a Time object
def to_time(date_string, site)
  # assume that the date is in the format YYYY-MM-DD.
  # performing .to_s to make sure date_string is a string,
  # cause sometimes it's a Date object..
  date = DateTime.parse(date_string.to_s)
  # Get the timezone
  timezone = site.config['timezone']
  local_tz = TZInfo::Timezone.get(timezone)
  # Create a DateTime object at midnight in UTC
  utc_midnight = DateTime.new(date.year, date.month, date.day, 0, 0, 0, '+00:00')
  # Convert the UTC DateTime to local timezone
  local_midnight = local_tz.to_local(utc_midnight)
  # Set the hour, minute, and second to the local DateTime object
  h = date.hour || 0
  m = date.minute || 0
  s = date.second || 0
  local = DateTime.new(local_midnight.year, local_midnight.month, local_midnight.day, h, m, s, local_midnight.zone)
  # returing a Time object as post.date from Jekyll itself
  return local.to_time
end

def truncate_words(text, num_words)
  words = text.split
  if words.size > num_words
    words[0...num_words].join(' ') + '...'
  else
    text
  end
end

