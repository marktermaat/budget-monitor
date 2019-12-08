def convert_timestamp(timestamp)
  case timestamp
  when 'now'
    @times[:now] || Time.now
  else
    timestamp
  end
end