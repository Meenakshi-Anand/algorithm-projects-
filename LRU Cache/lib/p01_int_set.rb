class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max)
  end

  def insert(num)
    raise "Out of bounds" if num > @max || num < 0
    @store[num] = true
  end

  def remove(num)
    raise "Out of bounds" if num > @max
    @store[num] = false
  end

  def include?(num)
    raise "Out of bounds" if num > @max
    @store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % @store.length] << num
  end

  def remove(num)
    bucket_no = num % 20
    @store[bucket_no].each_with_index do |no,idx|
       @store[bucket_no][idx] = nil if no == num
    end

  end

  def include?(num)
    bucket_no = num % 20
    @store[bucket_no].each do |no|
      return true if num == no
    end
    return false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if @count >= @store.length
    bucket_no = num % @store.length
    @store[bucket_no] << num
    @count += 1
  end

  def remove(num)
    bucket_no = num % @store.length
    @store[bucket_no].each_with_index do |no,idx|
      @store[bucket_no][idx]=nil if num == no
    end
  end

  def include?(num)
    bucket_no = num % @store.length
    @store[bucket_no].each do |no|
      return true if num == no
    end
    return false
  end


  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_length = @store.length * 2
    new_store = Array.new(new_length) { Array.new }
    new_count = 0
    (@store.length).times do |i|
      @store[i].each do |n|
         new_bucket = n % new_length
         new_store[new_bucket] << n
         new_count += 1
      end
    end
    @store = new_store
  end
end
