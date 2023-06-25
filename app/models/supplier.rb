class Supplier < ApplicationRecord
    def self.get_supplier_name(supplier_id)
        return Supplier.find(supplier_id)
    end
end
