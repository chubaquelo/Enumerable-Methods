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
    # Elsif for Regular Expression
    elsif type.is_a?(Regexp)
      self.my_each do |e|
        classflag = true
        if e.is_a?(String)
          if e.match?(type)
            classflag = true
          else
            return false
          end
        end
      end
      return true
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
      self.my_each do |m|
        if m == nil 
          return false
        end
      end
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
          if e.match?(cond)
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
          if e.match?(cond)
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
      if self.to_a.empty?
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
def my_map(pr = nil)
  new_array = []
  if pr.is_a?(Proc)
    self.my_each do |e|
      new_array.push(pr.call(e))
    end
    return new_array
  elsif block_given?
    self.my_each do |e|
      new_array.push(yield e)
    end
    new_array
  else
    new_array = self
    new_array
  end
end

# my_inject Method
def my_inject(init = 0)
  res = init
  self.my_each do |e|
    res = yield res, e
  end
  res
end

# my_map_proc Method
def my_map_proc(pr)
  new_array = []
  if pr.is_a?(Proc)
    self.my_each do |e|
      new_array.push(pr.call(e))
    end
    return new_array
  elsif
    new_array = self
    new_array
  end
end
end

# multiply_els Method
def multiply_els(arr)
  res = arr.my_inject(1) { |result, element| result * element }
  res
end
