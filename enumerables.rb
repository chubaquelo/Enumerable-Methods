array = [5, 6, 7, 8, 9]

module Enumerable
  # Each methods
  def my_each
    index = 0
    while index < self.size do
      yield self[index]
      index += 1
    end
    self
  end

  # Each index
  def my_each_with_index
    index = 0
    while index < self.size do
      yield(Array(self)[index], index)
      index += 1
    end
    self
  end

  # my_select Method
  def my_select
    new_arr = []
    self.my_each do |n|
        new_arr << n if yield(n)
    end
    new_arr
  end

  # my_all Method

end

# [1,2,3,4,5].my_each {|n| print n}
# p [1,2,3,4,5].my_select { |n| n.even? }