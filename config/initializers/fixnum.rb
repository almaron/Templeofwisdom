class Fixnum
  def digits(min = 1)
    arr = []
    c = self
    while c > 0 do
      arr << c % 10
      c = c / 10
    end
    (min - arr.size).times { |i| arr << 0 }
    arr
  end
end