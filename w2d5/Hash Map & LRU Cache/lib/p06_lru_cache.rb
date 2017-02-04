require 'byebug'

require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      p "#{@map.get(key)}"
      update_link!(@map.get(key))
      @map.get(key)
    else
      # debugger
      val = calc!(key)
      @map.set(key, val)
      @store.append(key, val)
      eject! if count > @max
      val
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    @prc.call(key)
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    p "#{link}"
    @store.remove(link.key)
    #link.remove
    @store.append(link.key, link.value)
  end

  def eject!
    @map.delete(@store.first)
    @store.remove(@store.first)
  end
end
