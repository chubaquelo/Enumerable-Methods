# rubocop:disable Metrics/ModuleLength, Metrics/MethodLength, Layout/IndentationWidth, Layout/EndAlignment, Layout/ElseAlignment, Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Metrics/BlockNesting

module Enumerable
  # Each methods
  def my_each
    index = 0
    while index < size
      yield to_a[index]
      index += 1
    end
    self
  end

  # Each index
  def my_each_with_index
    index = 0
    while index < to_a.length
      yield(Array(self)[index], index)
      index += 1
    end
    self
  end

  # my_select Method
  def my_select
    new_arr = []
    my_each do |n|
      new_arr << n if yield(n)
    end
    new_arr
  end

  # my_all Method
  def my_all?(type = nil)
    if block_given? and type.nil?
      flag = true
      my_each do |n|
        if n.is_a?(String)
          flag = false unless yield(n)
        elsif n.is_a?(Numeric)
          flag = false unless yield(n)
        end
      end
      flag
    # Elsif for Regular Expression
    elsif type.is_a?(Regexp)
      my_each do |e|
        if e.is_a?(String)
          return false unless e.match?(type)
        end
      end
      true
    # Elsif for Class argument query
    elsif type.is_a?(Class) and type != Numeric and !type.nil?
      classflag = true
      firstclass = self[0].class.name
      my_each do |m|
        classflag = false if m.class.name != firstclass
      end
      classflag = false if empty?
      classflag
    # Elsif for Numeric superclass query
    elsif type == Numeric
      classflag = true
      my_each do |m|
        if m.class.superclass.name != 'Numeric'
          classflag = false
        elsif empty?
          classflag = false
        end
      end
      classflag
    elsif !block_given? and type.nil?
      my_each do |m|
        return false if m.nil?
      end
      true
    end
  end

  # my_any? Method

  def my_any?(cond = nil)
    classflag = false
    if !cond.nil?
      if cond.is_a?(Class)
        my_each do |e|
          if e.is_a?(cond)
            classflag = true
            break
          end
        end
      elsif cond == Numeric
        my_each do |e|
          if e.is_a?(Numeric)
            classflag = true
            break
          end
        end
      elsif !cond.is_a?(Numeric) and cond.include?(true || false)
        my_each do |e|
          if e == cond
            classflag = true
            break
          end
        end
      elsif cond != Class and cond.is_a?(Regexp)
        my_each do |e|
          if e.is_a?(String)
            if e.match?(cond)
              classflag = true
              break
            end
          end
        end
      elsif cond.is_a?(Numeric) || cond.is_a?(String)
        my_each do |e|
          if cond == e
            classflag = true
            break
          end
        end
      end
    elsif block_given?
      my_each do |e|
        if yield(e)
          classflag = true
          break
        end
      end
    elsif cond.nil? and !block_given?
      classflag = if empty?
              false
            else
              true
            end
    else
      false
    end
    classflag
  end

  # my_none Method
  def my_none?(cond = nil)
    classflag = true
    if !cond.nil?
      if cond.is_a?(Class)
        my_each do |e|
          if e.is_a?(cond)
            classflag = false
            break
          end
        end
      elsif cond == Numeric
        my_each do |e|
          if e.is_a?(Numeric)
            classflag = false
            break
          end
        end
      elsif cond.is_a?(Boolean)
        my_each do |e|
          if e == cond
            classflag = false
            break
          end
        end
      elsif cond != Class and cond.is_a?(Regexp)
        my_each do |e|
          if e.is_a?(String)
            if e.match?(cond)
              classflag = false
              break
            end
          end
        end
      elsif cond.is_a?(Numeric) || cond.is_a?(String)
        my_each do |e|
          if cond == e
            classflag = false
            break
          end
        end
      end

    elsif block_given?
      my_each do |e|
        if yield(e)
          classflag = false
          break
        end
      end
    elsif cond.nil? and !block_given?
      classflag = if to_a.empty?
        true
      else
        false
      end
    else
      true
    end
    classflag
  end

  # my_none Method (another approach), didn't work because we couldn't use yield on a yield...
  # def my_none_2?(cond = nil)
  #   res = false
  #   if !cond.nil?
  #     inv = self.my_any?(cond)
  #   elsif block_given?
  #     block = yield
  #     inv = self.my_any? {yield.to_s}
  #   end
  #   inv == true ? res = false : res = true
  #   res
  #   block
  # end

  # my_count Method
  def my_count(cond = nil)
    counter = 0
    if block_given?
      my_each do |f|
        counter += if yield f
        end
        counter
      end
    elsif cond.nil?
      length
    elsif !cond.nil?
      my_each do |e|
        counter += 1 if cond == e
      end
      counter
    end
  end

  # my_map method
  def my_map(pro = nil)
    new_array = []
    if pro.is_a?(Proc)
      my_each do |e|
        new_array.push(pro.call(e))
      end
      new_array
    elsif block_given?
      my_each do |e|
        new_array.push(yield e)
      end
      new_array
    else
      new_array = self
    end
    new_array
  end

  # my_inject Method
  def my_inject(init = 0)
    res = init
    my_each do |e|
      res = yield res, e
    end
    res
  end

  # my_map_proc Method
  def my_map_proc(pro)
    new_array = []
    if pro.is_a?(Proc)
      my_each do |e|
        new_array.push(pro.call(e))
      end
      new_array
    else
      new_array = self
    end
    new_array
  end
end

# multiply_els Method
def multiply_els(arr)
  res = arr.my_inject(1) { |result, element| result * element }
  res
end
# rubocop:enable Metrics/ModuleLength, Metrics/MethodLength, Layout/IndentationWidth, Layout/EndAlignment, Layout/ElseAlignment, Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Metrics/BlockNesting
