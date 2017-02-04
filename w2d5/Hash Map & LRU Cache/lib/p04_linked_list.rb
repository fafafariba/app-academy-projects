class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @next.prev = @prev
    @prev.next = @next
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    p "we are now here"
    each { |link| return link.val if link.key == key }
  end

  def include?(key)
    any? { |link| link.key == key }
  end

  def append(key, val)
    new_link = Link.new(key, val)
    new_link.next = @tail
    last.next = new_link
    new_link.prev = last
    @tail.prev = new_link
  end

  def update(key, val)
    each { |link| link.val = val if link.key == key }
  end

  def remove(key)
    each { |link| link.remove if link.key == key }
  end

  def each
    curr_link = first
    until curr_link.key.nil?
      yield(curr_link)
      curr_link = curr_link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
