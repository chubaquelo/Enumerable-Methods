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

  # My Select Method
  def my_select
  end

end

# [1,2,3,4,5].my_each {|n| print n}
[1,2,3,4,5].my_select { |n| n.even? }