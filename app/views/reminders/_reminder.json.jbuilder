json.extract! reminder, :id, :reminder_text, :created_at, :updated_at
json.url reminder_url(reminder, format: :json)
json.reminder_text reminder.reminder_text.to_s
