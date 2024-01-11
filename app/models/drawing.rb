class Drawing < ApplicationRecord
  belongs_to :drink
    def self.sum_drawing_for_today(sent_date)
    draw = Drawing.last(100)
    filtered_drawings = draw.select {|x| x.created_at.strftime("%Y-%m-%d") == sent_date }
    sum = 0
    filtered_drawings.each do |d|
      sum += d.drink.buying_cost * d.quantity
    end
    return sum
  end
end
