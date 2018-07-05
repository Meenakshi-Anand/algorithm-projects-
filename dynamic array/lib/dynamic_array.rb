require_relative "static_array"
class DynamicArray
  attr_reader :length
  def initialize
    @store = StaticArray.new(8)
    @length = 0
    @capacity = 8
  end
  # O(1)
  def [](index)
    if index >= @length
      raise 'index out of bounds'
    else
      @store[index]
    end
  end
  # O(1)
  def []=(index, value)
    if index >= @length
      raise 'index out of bounds'
    else
      @store[index] = value
    end
  end
  # O(1)
  def pop
    raise "index out of bounds" unless @length > 0
    last = @store[@length-1]
    @length -= 1
    @store[@length] = nil
    last
  end
  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity
    @store[@length] = val
    @length += 1
    @store
  end
  # O(n): has to shift over all the elements.
  def shift
    raise 'index out of bounds' unless @length > 0
    first = @store[0]
    temp = StaticArray.new(@capacity)
    (1...@length).each do |i|
      temp[i - 1] = @store[i]
    end
    @store = temp
    @length -= 1
  end
  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == @capacity
    temp = StaticArray.new(@capacity)
    temp[0] = val
    (0...length).each do |i|
      temp[i + 1] = @store[i]
    end
    @store = temp
    @length += 1
  end
  protected
  attr_accessor :capacity, :store
  attr_writer :length
  def check_index(index)
  end
  # O(n): has to copy over all the elements to the new store.
  def resize!
    temp = StaticArray.new(@capacity * 2)
    length.times do |i|
      temp[i] = @store[i]
    end
    @store = temp
    @capacity *= 2
  end
end
