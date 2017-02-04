require 'byebug'

#for testing... my_min => -5
 list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]

def my_min(array)
  lowest_value = array.first

  i = 0
  while i < array.length - 1
    j = i +1
    while j < array.length
      if array[i] < array[j]
        lowest_value = array[i] if array[i] < lowest_value
      end
      j += 1
    end
    i += 1
  end
  lowest_value
end



def faster_my_min(array)

  lowest = array.first
  array.each do |el|
    lowest = el if el < lowest
  end
  lowest
end

faster_my_min(list)


list2 = [2, 3, -6, 7, -6, 7]

def largest_contiguous_sub_sum(array) #O(n^2)
  sub_arrays =[]

  i = 0
  while i < array.length - 1
    j = i + 1
    while j < array.length
      sub_arrays << array[i..j]
      j += 1
    end
    i += 1
  end

  max_sum = 0

  sub_arrays.each do |arr| #n^2
    total = arr.reduce(:+) #n^3
    max_sum = total if total > max_sum
  end
  max_sum
end


neg_list = [-5, -1, -3]

def faster_largest_contiguous_sub_sum(array) #O (n)
  current = nil
  lcs = nil
  array.each do |num|
    if current.nil?
      current = num
      lcs = num
    else
      current += num
      lcs = current if current > lcs
    end
    current = 0 if current < 0
  end
  lcs
end


p faster_largest_contiguous_sub_sum(list2)
