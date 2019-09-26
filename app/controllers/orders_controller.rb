class OrdersController < ApplicationController
  # def edit
    # binding.pry
    # @cars = Order.last
    
    # carname = Carname.find_by(address:Order.last.name)
    # @carname = carname.maker_name
    
    # model = Product.select(:model).distinct
    
    # keywords  = params[:keyword].to_s
    # keywords  = keywords + " "
    # keywords  = keywords.gsub!(/[[:space:]]/, ' ').to_s
    # keywords  = keywords.split(/ /)
    
    # if params[:keyword] != ""
    #   @model = model
    #     keywords.each do |a_keyword| 
    #       @model = @model.where('model LIKE(?)', "%#{a_keyword}%")
        
    #     end
    # end

    # @model = model.where('model LIKE(?)', "%#{params[:keyword]}%") unless params[:keyword]==""
    
    # respond_to do |format|
    #   format.json
    #   format.html
      
    # end
  # end
  

  def update
    
    order = Order.last
    if order.present?
      order.update(params.require(:product).permit(:model))
      order.update(params.require(:order).permit(:model, :exhaust,:modelyear, :color,:distance, :price,:repare))
    end
  
    redirect_to controller: :products, action: :index
  end
end
