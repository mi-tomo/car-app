class Array
  def reg_line(y)
  # 以下の場合は例外スロー
  # - 引数の配列が Array クラスでない
  # - 自身配列が空
  # - 配列サイズが異なれば例外
raise "Argument is not a Array class!"  unless y.class == Array
raise "Self array is nil!"              if self.size == 0
raise "Argument array size is invalid!" unless self.size == y.size

n      = self.size                                          # number of items
m_x    = self.sum / n.to_f                                  # avg(X)
m_y    = y.sum / n.to_f                                     # avg(Y)
m_x2   = self.map { |x| x ** 2 }.sum / n.to_f               # avg(X^2)
m_x3   = self.map { |x| x ** 3 }.sum / n.to_f               # avg(X^3)
m_x4   = self.map { |x| x ** 4 }.sum / n.to_f               # avg(X^4)
m_xy   = self.zip(y).map { |a, b| a * b }.sum / n.to_f      # avg(X * Y)
m_x2y  = self.zip(y).map { |a, b| a * a * b }.sum / n.to_f  # avg(X^2 * Y)
s_xx   = m_x2 - m_x * m_x                                   # Sxx
s_xy   = m_xy - m_x * m_y                                   # Sxy
s_xx2  = m_x3 - m_x * m_x2                                  # Sxx2
s_x2x2 = m_x4 - m_x2 * m_x2                                 # Sx2x2
s_x2y  = m_x2y - m_x2 * m_y                                 # Sx2y
b  = s_xy * s_x2x2 - s_x2y * s_xx2
b /= s_xx * s_x2x2 - s_xx2 * s_xx2
c  = s_x2y * s_xx - s_xy * s_xx2
c /= s_xx * s_x2x2 - s_xx2 * s_xx2
a = m_y - b * m_x - c * m_x2
{a: a, b: b, c: c}       
end

 def self.approximate_xy(ary_x , ary_y)


reg_line = ary_x.reg_line(ary_y)
a = reg_line[:a]
b = reg_line[:b]
c = reg_line[:c]
puts "a = #{reg_line[:a]}"
puts "b = #{reg_line[:b]}"
puts "c = #{reg_line[:c]}"

n_kinji = []

x = 0
while x < 15 do
  kinji = [] 
  y = a + b * x + c * x ** 2
  kinji.push(x, y)
  n_kinji << kinji
  x = x + 0.1
end

return n_kinji
end
end

