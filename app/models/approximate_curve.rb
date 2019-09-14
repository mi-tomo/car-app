# class Approximate 
#     def self.reg_line(y)
#       # 以下の場合は例外スロー
#       # - 引数の配列が Array クラスでない
#       # - 自身配列が空
#       # - 配列サイズが異なれば例外
#       raise "Argument is not a Array class!"  unless y.class == Array
#       raise "Self array is nil!"              if self.size == 0
#       raise "Argument array size is invalid!" unless self.size == y.size

#       n      = self.size                                          # number of items
#       m_x    = self.sum / n.to_f                                  # avg(X)
#       m_y    = y.sum / n.to_f                                     # avg(Y)
#       m_x2   = self.map { |x| x ** 2 }.sum / n.to_f               # avg(X^2)
#       m_x3   = self.map { |x| x ** 3 }.sum / n.to_f               # avg(X^3)
#       m_x4   = self.map { |x| x ** 4 }.sum / n.to_f               # avg(X^4)
#       m_xy   = self.zip(y).map { |a, b| a * b }.sum / n.to_f      # avg(X * Y)
#       m_x2y  = self.zip(y).map { |a, b| a * a * b }.sum / n.to_f  # avg(X^2 * Y)
#       s_xx   = m_x2 - m_x * m_x                                   # Sxx
#       s_xy   = m_xy - m_x * m_y                                   # Sxy
#       s_xx2  = m_x3 - m_x * m_x2                                  # Sxx2
#       s_x2x2 = m_x4 - m_x2 * m_x2                                 # Sx2x2
#       s_x2y  = m_x2y - m_x2 * m_y                                 # Sx2y
#       b  = s_xy * s_x2x2 - s_x2y * s_xx2
#       b /= s_xx * s_x2x2 - s_xx2 * s_xx2
#       c  = s_x2y * s_xx - s_xy * s_xx2
#       c /= s_xx * s_x2x2 - s_xx2 * s_xx2
#       a = m_y - b * m_x - c * m_x2
#       {a: a, b: b, c: c}
#     end

#     def approximate_xy(ary_x , ary_y)
#     # 説明変数と目的変数
#     #ary_x = [107, 336, 233, 82, 61, 378, 129, 313, 142, 428]
#     #ary_y = [286, 851, 589, 389, 158, 1037, 463, 563, 372, 1020]
#     # ary_x = [83, 71, 64, 69, 69, 64, 68, 59, 81, 91, 57, 65, 58, 62]
#     # ary_y = [183, 168, 171, 178, 176, 172, 165, 158, 183, 182, 163, 175, 164, 175]
#     # puts "説明変数 X = {#{ary_x.join(', ')}}"
#     # puts "目的変数 Y = {#{ary_y.join(', ')}}"
#     # puts "---"

#     # 単回帰曲線算出
#     reg_line = ary_x.reg_line(ary_y)
#     puts "a = #{reg_line[:a]}"
#     puts "b = #{reg_line[:b]}"
#     puts "c = #{reg_line[:c]}"
#     n_kinji = []
#     xs = [0,1,2,3,4,5,6,7,8,9,10]
#         xs.each do |x|
#         kinji = []
#         y = a + b * x + c * x ** 2
#         kinji.push(x, y)
#         n_kinji << kinji
#         end
#     return n_kinji
#     end
# end