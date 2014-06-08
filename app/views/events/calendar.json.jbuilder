json.array!(current_knocker.events) do |event|
  json.extract! event, :id, :description
  json.title event.name
  json.start event.start_time
  json.end event.end_time
  json.url event_url(event, format: :html)
end