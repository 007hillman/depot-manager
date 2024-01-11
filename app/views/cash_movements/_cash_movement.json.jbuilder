json.extract! cash_movement, :id, :amount, :cash_in, :cash_out, :person, :created_at, :updated_at
json.url cash_movement_url(cash_movement, format: :json)
