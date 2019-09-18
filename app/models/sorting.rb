class Sorting
  def self.sorting_products
    @products = Product.where(repare: "なし").where.not(evaluation: "R"||""||nil).where.not(price: "---"||""||nil).where.not(distance: "---"||""||nil).order("distance DESC")
    @products = @products.where.not(evaluation: "S"||"1"||"2"||"6")unless Product.first.name == ""
    unless Product.first.model == ""
        models = Product.first.model + " "
        models = models.gsub!(/[[:space:]]/, ' ')
        # binding.pry
        models = models.split(/ /)
        
        models.each do |a_model|
          @products = @products.where('model LIKE(?)', "%#{a_model}%")
        end
    end
    
    # @products = @products.where('model LIKE(?)', "%#{Product.first.model}%") unless Product.first.model == ""
    @products = @products.where('color LIKE(?)', "%#{Product.first.color}%") unless Product.first.color == ""
    @products = @products.where(modelyear: Product.first.modelyear)if Product.first.modelyear != ""
    @products = @products.where(exhaust: Product.first.exhaust)if Product.first.exhaust != ""
    return @products
  end
end