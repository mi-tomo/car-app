class Sorting
  def self.sorting_products(order_id)
    
    current_order = Order.find(order_id)
    @products = Product.where(session_id: current_order.session_id)
    @products = @products.where(repare: "なし").where.not(evaluation: "R"||""||nil).where.not(price: "---"||""||nil).where.not(distance: "---"||""||nil).order("distance DESC")
    
    @products = @products.where.not(evaluation: "S"||"1"||"2"||"6")unless current_order.name == ""||current_order.name == nil
    
    unless current_order.model == "" ||current_order.model == nil
        models = current_order.model + " "
        models = models.gsub!(/[[:space:]]/, ' ')
        
        models = models.split(/ /)
        
        models.each do |a_model|
          @products = @products.where('model LIKE(?)', "%#{a_model}%")
        end
        
    end
    
   
    @products = @products.where('color LIKE(?)', "%#{current_order.color}%") unless current_order.color == ""||current_order.color == nil
    
    @products = @products.where(modelyear: current_order.modelyear)unless current_order.modelyear == ""|| current_order.modelyear == nil
    
    @products = @products.where(exhaust: current_order.exhaust)unless current_order.exhaust == "" || current_order.exhaust == nil
    
    return @products
    
  end
end