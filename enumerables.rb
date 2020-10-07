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
    # Elsif for Class argument query
    elsif type.is_a?(Class) and type != Numeric and type != nil
      classflag = true
      firstclass = self[0].class.name
      self.my_each do |m|
        if m.class.name != firstclass
          classflag = false
        end
      end
      if self.empty?
        classflag = false
      end
      classflag
    # Elsif for Numeric superclass query
    elsif type == Numeric
      classflag = true
      self.my_each do |m|
        if (m.class.superclass.name != "Numeric")
          classflag = false
        elsif self.empty?
          classflag = false
        end
      end
      classflag
    elsif not block_given? and type == nil
      true
    end
  end

# my_any? Method

def my_any?(cond = nil)
  classflag = false
  if cond != nil
    if cond.is_a?(Class)
      self.my_each do |e|
        if e.is_a?(cond)
          classflag = true
          break
        end
      end
    elsif cond == Numeric
      self.my_each do |e|
        if e.is_a?(Numeric)
          classflag = true
          break
        end
      end
    elsif cond == true || cond == false
      self.my_each do |e|
        if e == cond
          classflag = true
          break
        end
      end
    elsif cond != Class and cond.is_a?(Regexp)
      self.my_each do |e|
        if e.is_a?(String)
          if e.match(cond)
            classflag = true
            break
          end
        end
      end
    elsif cond.is_a?(Numeric) || cond.is_a?(String)
      self.my_each do |e|
        if cond == e
          classflag = true
          break
        end
      end
    end
  elsif block_given?
      self.my_each do |e|
        if yield(e)
          classflag = true
          break
        end
      end
  elsif cond == nil and not block_given?
    if self.empty?
      classflag = false
    else
      classflag = true
    end
  else
    false
  end
    classflag
  end

# my_none Method
def my_none?(cond = nil)
  classflag = true
  if cond != nil
    if cond.is_a?(Class)
      self.my_each do |e|
        if e.is_a?(cond)
          classflag = false
          break
        end
      end
    elsif cond == Numeric
      self.my_each do |e|
        if e.is_a?(Numeric)
          classflag = false
          break
        end
      end
    elsif cond == true || cond == false
      self.my_each do |e|
        if e == cond
          classflag = false
          break
        end
      end
    elsif cond != Class and cond.is_a?(Regexp)
      self.my_each do |e|
        if e.is_a?(String)
          if e.match(cond)
            classflag = false
            break
          end
        end
      end
    elsif cond.is_a?(Numeric) || cond.is_a?(String)
      self.my_each do |e|
        if cond == e
          classflag = false
          break
        end
      end
    end

  elsif block_given?
      self.my_each do |e|
        if yield(e)
          classflag = false
          break
        end
      end
    elsif cond == nil and not block_given?
      if self.empty?
        classflag = true
      else
        classflag = false
      end
    else
      true
    end
      classflag
    end

# my_none Method (another approach)
def my_none_2?(cond = nil)
  res = false
  if cond != nil
    inv = self.my_any?(cond)
  elsif block_given?
    block = yield
    inv = self.my_any? {yield.to_s}
  end
  inv == true ? res = false : res = true
  res
  block
end

# my_count Method

def my_count(cond = nil)
  counter = 0
  if block_given?
    self.my_each do |f|
      if yield f
        counter += 1
      end
    end
    counter
  elsif cond == nil
    self.length
  elsif cond != nil
    self.my_each do |e|
      if cond == e
        counter += 1
      end
    end
    counter
  end
end

# my_map method
# def my_map
#   new_array = []
#   if block_given?
#     self.my_each |e| do
#       if yield(e)
#         new_array.push(e)
#       end
#     end
#     new_array
#   else
#     new_array = self
#     new_array
#   end
# end

end



# p [1,2,3,4,5].map
#my_count test
# p [1, 2, 4, 4].count {|n| n == 4}
# p [1, 2, 4, 4].my_count {|n| n == 4}
p [].count
p [].my_count
#my_none test
# p [1,2,3,"ser"].any?("dsf")
# p [1,2,3,"ser"].my_any?("dsf")
# p [1].my_none_2? { |n| n == 1 }

# [1,2,3,4,5].my_each {|n| print n}
# p [1,2,3,4,5].my_select { |n| n.even? }
# p ["text", "tas", "aasdf"].my_all? { |n| n.length <= 2 }
# p [1,2,"s"].my_all?(Integer)
# p [1,2,"a"].all?(Integer)
# p [2, 1.5, 4i].my_all?(Numeric)
# p 3.14.class.name