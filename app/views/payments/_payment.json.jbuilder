json.extract! payment, :id, :client_id, :amount_paid, :command_id, :created_at, :updated_at
json.url payment_url(payment, format: :json)
