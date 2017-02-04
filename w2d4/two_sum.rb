require "byebug"

def bad_two_sum?(arr, target) # O(n^2)

  i = 0 # O(1)
  while i < arr.length - 1 # O(n) iteration
    j = i + 1 # O(1)
    while j < arr.length # O(n)
      return true if arr[i] + arr[j] == target # O(1)
      j += 1 # O(1)
    end
    i += 1 # O(1)
  end
  false # O(1)
end



def okay_two_sum?(arr, target)
  arr.sort!  #n log n
  return false if (arr[-1] + arr[-2]) < target #O(1)
  return false if (arr[0] + arr[1]) > target # O(1)


  while arr.length > 0 #O(n)
    sub_target = target - arr.shift #O(n) probably O(1)
      return false if arr.empty? # O(1)
      return true if arr.include?(sub_target) #O(n)

    until arr.last < sub_target #O(1)
      arr.pop #O(1)
    end
  end
end




def hash_two_sum?(arr, target)
  hash = {}
  arr.each do |num|
    hash[num] = target - num
  end
  p hash

  hash.each do |k,v|
    puts v
    return true if hash.has_key?(v) && k != v
  end
  false

  

arr = [0, 1, 5, 7]
p hash_two_sum?(arr, 6) # => should be true
p hash_two_sum?(arr, 10) # => should be false
