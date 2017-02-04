class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    final_hash = 0
    each_with_index do |el, i|
      final_hash += el.hash ^ i.hash #no uniform operations
    end
    final_hash.hash
  end

end

class String
  def hash
    final_hash = 0
    self.chars.each_with_index do |char, i|
      final_hash += char.ord.hash ^ i.hash
    end
    final_hash.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    final_hash = 0
    each do |k, v|
      final_hash ^= k.hash ^ v.hash
    end
    final_hash.hash
  end
end
