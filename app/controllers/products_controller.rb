require "array.rb"
class ProductsController < ApplicationController
  before_action :move_to_index, except: [:new,:create]
  def index
  
    # @products = Product.where(repare: "なし").where.not(evaluation: "R" or ""or null).where.not(price: ""or null).order("distance DESC")
  @products = Product.where(repare: "なし").where.not(evaluation: "R"||""||nil).where.not(price: "---"||""||nil).where.not(distance: "---"||""||nil).order("distance DESC")
  @products = @products.where.not(evaluation: "S"||"1"||"2"||"6")unless Product.first.name == ""
  @products = @products.where('model LIKE(?)', "%#{Product.first.model}%") unless Product.first.model == ""
  @products = @products.where('color LIKE(?)', "%#{Product.first.color}%") unless Product.first.color == ""
  @products = @products.where(modelyear: Product.first.modelyear)if Product.first.modelyear != ""
  @products = @products.where(exhaust: Product.first.exhaust)if Product.first.exhaust != ""
  
  # @products = @products.where(evaluation: "5")
  x = []
  y = []
  n_data = []
  @products.each do |product|
   data = []
   distance = product.distance.to_f
   x.push(distance)
   price = product.price.to_f
   y.push(price)
   data.push(distance, price)
   n_data << data
  end
  

 @data = n_data
  
  unless @products[0] == nil
  abc_approximate = Array.approximate_xy(x, y) 
  abc = abc_approximate[0]
  @hantei0="購入検討車の「走行距離」と「金額」を詳細条件から入力してください"
    unless Product.first.distance == "" && Product.first.distance ==""
    hikakukyori = Product.first.distance.to_i
    heikinprice = abc[0] + abc[1] * hikakukyori + abc[2] * hikakukyori ** 2
    hikakuresult = [[hikakukyori,Product.first.price.to_i]]
        if heikinprice > Product.first.price.to_i
          sagaku = heikinprice - Product.first.price.to_i
          @hantei1 = "相場平均価格より_#{sagaku.round(1)}万円_割安です"
          @hantei2 =""
          @hantei0=""
        else 
          sagaku = Product.first.price.to_i - heikinprice
          @hantei2 = "相場平均価格より_#{sagaku.round(1)}万円_割高です（要再検討）"
          @hantei1=""
          @hantei0=""
        end
    end
  
  @approximate = abc_approximate.drop(1)
  # binding.pry
  maltidata1={}
  maltidata1[:name]  ="市場"
  maltidata1[:data]  = n_data
  maltidata2={}
  maltidata2[:name]  ="近似曲線"
  maltidata2[:data]  = @approximate
  maltidata3={}
  maltidata3[:name]  ="検討中案件"
  maltidata3[:data]  = hikakuresult
end
  
  @maltidata=[maltidata1,maltidata2,maltidata3]
  carname = Carname.find_by(address:Product.first.name)
  @carname = carname.maker_name
end

  def new
    
    product = Product.all
    num = Product.count
    product.where(id: 1..999999).destroy_all
    @cars=Product.new
    
  end
  def destroy
    product = Product.all
    num = Product.count
    product.where(id: 1..999999).destroy_all
   
    redirect_to controller: :products, action: :new

    end
  def create
   
    Product.create(params.require(:product).permit( :name,:model, :exhaust,:modelyear, :color,:distance, :price,:repare))
     
    Scraping.scraping_url(params.require(:product).permit( :name)[:name])
    redirect_to controller: :products, action: :index
  
  end

  def edit
    
    @cars = Product.first
    carname = Carname.find_by(address:Product.first.name)
    @carname = carname.maker_name

    @model = Product.where('model LIKE(?)', "%#{params[:keyword]}%") unless params[:keyword]==""
    
    respond_to do |format|
      format.json
      format.html
      
    end
  end
  

  def update
    product = Product.first
    if product.present?
      product.update(params.require(:product).permit(:model, :exhaust,:modelyear, :color,:distance, :price,:repare))
    end
    redirect_to controller: :products, action: :index
  end
  # private
  # def product_params
    
  #   params.require(:product).permit(:maker, :name,:model, :exhaust,:modelyear, :color,:distance, :price,:repare)
    
  private
  def move_to_index
    product = Product.first
    redirect_to controller: :products, action: :new if product == nil
  end
  
end
