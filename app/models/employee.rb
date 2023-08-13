class Employee < ApplicationRecord
    has_many :client_employees
    has_many :clients, through: :client_employees
end
