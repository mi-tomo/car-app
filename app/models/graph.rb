#  グラフ 用値格納
# x = []
# y = []
# n_data = []
#   @products.each do |product|
#   data = []
#   distance = product.distance.to_f
#   x.push(distance)
#   price = product.price.to_f
#   y.push(price)
#   data.push(distance, price)
#   n_data << data
#   end
# 飛び値トリム
# if x.count >= 5
#   xmax = x.max(5)
#   ymax = y.max(5)
#   for i in 0..2 do
#     if ymax[i]-ymax[4] > 200
#       tobiti = y.index(y.max)
#       x.delete_at(tobiti)
#       y.delete_at(tobiti)
#       n_data.delete_at(tobiti)
#     end
#   end
# end
# 購入予定価格と相場の比較判定
# unless @products[0] == nil
# abc_approximate = Array.approximate_xy(x, y) 

# abc = abc_approximate[0]
# @hantei0="購入検討車の「走行距離」と「金額」を詳細条件から入力してください"
#   unless Product.first.distance == "" && Product.first.distance ==""
#   hikakukyori = Product.first.distance.to_i
#   heikinprice = abc[0] + abc[1] * hikakukyori + abc[2] * hikakukyori ** 2
#   hikakuresult = [[hikakukyori,Product.first.price.to_i]]
#       if heikinprice > Product.first.price.to_i
#         sagaku = heikinprice - Product.first.price.to_i
#         @hantei1 = "相場平均価格より_#{sagaku.round(1)}万円_割安です"
#         @hantei2 =""
#         @hantei0=""
#       else 
#         sagaku = Product.first.price.to_i - heikinprice
#         @hantei2 = "相場平均価格より_#{sagaku.round(1)}万円_割高です（要再検討）"
#         @hantei1=""
#         @hantei0=""
#       end
#   end

# @approximate = abc_approximate.drop(1)
# # binding.pry
# maltidata1={}
# maltidata1[:name]  ="市場"
# maltidata1[:data]  = n_data
# maltidata2={}
# maltidata2[:name]  ="近似曲線"
# maltidata2[:data]  = @approximate
# maltidata3={}
# maltidata3[:name]  ="検討中案件"
# maltidata3[:data]  = hikakuresult
# end

# @maltidata=[maltidata1,maltidata2,maltidata3]
# carname = Carname.find_by(address:Product.first.name)
# @carname = carname.maker_name
