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
  def my_all?(type = nil)
    if block_given? and type == nil
      flag = true
      self.my_each do |n|
        if n.is_a?(String)
          flag = false if not yield(n)
        elsif n.is_a?(Numeric)
          flag = false if not yield(n)
        end
      end
      flag
    elsif type.is_a?(Class) and type != nil
      classflag = true
      firstclass = self[0].class.ancestors[0]
      self.my_each do |m|
        if m.class.ancestors[0] != firstclass
          classflag = false
        end
      end
      classflag
    end
  end
end


# [1,2,3,4,5].my_each {|n| print n}
# p [1,2,3,4,5].my_select { |n| n.even? }
# p ["text", "tas", "aasdf"].my_all? { |n| n.length <= 2 }
# p [nil].my_all?(Numeric) { |n| n.length >= 3 }

# p [2, 1.5, 4i].my_all?(Numeric)
# p 3.14.class.name