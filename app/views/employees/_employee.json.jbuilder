json.extract! employee, :id, :name, :surname, :date_of_birth, :salary, :created_at, :updated_at
json.url employee_url(employee, format: :json)
