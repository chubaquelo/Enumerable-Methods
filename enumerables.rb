array = [5, 6, 7, 8, 9]

module Enumerable
  #Each methods
  def my_each
    index = 0
    while index < self.size do
      yield self[index]
      index += 1
    end
    self
  end
  #Each index
  def my_each_with_index
    index = 0
    while index < self.size do
      yield(Array(self)[index], index)
      index += 1
    end
    self
  end
end

array.my_each_with_index do |n, i|
  print n
  puts i
  
end
