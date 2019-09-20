require "array.rb"
class ProductsController < ApplicationController
  before_action :move_to_index, except: [:new,:create]
  def index
  # productテーブル条件ソート
    @products = Sorting.sorting_products
  #  グラフ 用値格納
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
      # 飛び値トリム
      if x.count >= 5
        xmax = x.max(5)
        ymax = y.max(5)
        for i in 0..2 do
          if ymax[i]-ymax[4] > 200
            tobiti = y.index(y.max)
            x.delete_at(tobiti)
            y.delete_at(tobiti)
            n_data.delete_at(tobiti)
          end
        end
      end
  # require "graph.rb"
  unless @products[0] == nil
  #近似曲線算出  
  abc_approximate = Array.approximate_xy(x, y) 
  # 購入予定価格と相場の比較判定
  # binding.pry
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
  # グラフ 用データ
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
  # binding.pry
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
  # def destroy
  #   product = Product.all
  #   num = Product.count
  #   product.where(id: 1..999999).destroy_all
   
  #   redirect_to controller: :products, action: :new

  # end
  def create
   
    Product.create(params.require(:product).permit( :name,:model, :exhaust,:modelyear, :color,:distance, :price,:repare))
    #市場情報スクレープ
    Scraping.scraping_url(params.require(:product).permit( :name)[:name])
    redirect_to controller: :products, action: :index
  
  end

  def edit
    
    @cars = Product.first
    carname = Carname.find_by(address:Product.first.name)
    @carname = carname.maker_name
    
    model = Product.select(:model).distinct
    
    keywords  = params[:keyword].to_s
    keywords  = keywords + " "
    keywords  = keywords.gsub!(/[[:space:]]/, ' ').to_s
    keywords  = keywords.split(/ /)
    
    if params[:keyword] != ""
      @model = model
        keywords.each do |a_keyword| 
          @model = @model.where('model LIKE(?)', "%#{a_keyword}%")
        
        end
    end

    # @model = model.where('model LIKE(?)', "%#{params[:keyword]}%") unless params[:keyword]==""
    
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
