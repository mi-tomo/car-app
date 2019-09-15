require "array.rb"
class ProductsController < ApplicationController
  def index
    @cars = "プログラミングなう"
    
    # @products = Product.where(repare: "なし").where.not(evaluation: "R" or ""or null).where.not(price: ""or null).order("distance DESC")
  @products = Product.where(repare: "なし").where.not(evaluation: "R"||""||nil).where.not(price: "---"||""||nil).where.not(distance: "---"||""||nil).order("distance DESC")
  @products = @products.where.not(evaluation: "S"||"1"||"2"||"6")
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
      #配列形式でデータを用意する @data = [['2019-06-01', 100], ['2019-06-02', 200], ['2019-06-03', 150]]
          # ２項近似曲線（単回帰曲線）
  #  marutidata.push(n_data,approximate)     
  
  
  abc_approximate = Array.approximate_xy(x, y)
  abc = abc_approximate[0]
  @hantei = ""
  unless Product.first.distance == "" && Product.first.distance==""
  hikakukyori = Product.first.distance.to_i
  heikinprice = abc[0] + abc[1] * hikakukyori + abc[2] * hikakukyori ** 2
  hikakuresult = [[hikakukyori,Product.first.price.to_i]]
      if heikinprice > Product.first.price.to_i
       @hantei = "相場平均価格より割安です"
      else 
        @hantei = "相場平均価格より割高です（要再検討）"
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

  
  @maltidata=[maltidata1,maltidata2,maltidata3]
  # binding.pry
  # @maltidata = maltidata
  





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
    
  
  # end

end
