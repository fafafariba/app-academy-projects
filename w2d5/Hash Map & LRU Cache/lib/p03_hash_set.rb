require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(obj)
    resize! if @count >= num_buckets
    unless self.include?(obj)
      self[obj] << obj
      @count += 1
    end
  end

  def remove(obj)
    value = self[obj].delete(obj)
    @count -= 1 unless value.nil?
  end

  def include?(obj)
    self[obj].include?(obj)
  end

  private

  def [](obj)
    @store[obj.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    prev_store = @store.dup
    @store = Array.new(num_buckets * 2) { [] }
    @count = 0
    prev_store.each do |bucket|
      insert(bucket.first)
    end
  end
end
