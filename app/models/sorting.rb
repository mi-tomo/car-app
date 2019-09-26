class Sorting
  def self.sorting_products
    # binding.pry
    @products = Product.where(repare: "なし").where.not(evaluation: "R"||""||nil).where.not(price: "---"||""||nil).where.not(distance: "---"||""||nil).order("distance DESC")
    @products = @products.where.not(evaluation: "S"||"1"||"2"||"6")unless Order.last.name == ""||Order.last.name == nil
    unless Order.last.model == "" ||Order.last.model == nil
        models = Order.last.model + " "
        models = models.gsub!(/[[:space:]]/, ' ')
        # binding.pry
        models = models.split(/ /)
        
        models.each do |a_model|
          @products = @products.where('model LIKE(?)', "%#{a_model}%")
        end
    end
    
    # @products = @products.where('model LIKE(?)', "%#{Product.first.model}%") unless Product.first.model == ""
    @products = @products.where('color LIKE(?)', "%#{Order.last.color}%") unless Order.last.color == ""
    @products = @products.where(modelyear: Order.last.modelyear)if Order.last.modelyear != ""
    @products = @products.where(exhaust: Order.last.exhaust)if Order.last.exhaust != ""
    return @products
  end
end