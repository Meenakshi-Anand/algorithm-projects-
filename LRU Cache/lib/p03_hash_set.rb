require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count >= @store.length
    num = key.hash.to_i
    bucket_no = num % @store.length
    @store[bucket_no] << num
    @count += 1
  end

  def include?(key)
    num = key.hash
    bucket_no = num % @store.length
    @store[bucket_no].each do |no|
      return true if num == no
    end
    false
  end

  def remove(key)
    num = key.hash
    bucket_no = num % @store.length
    @store[bucket_no].each_with_index do |no,idx|
      @store[bucket_no][idx]=nil if num == no
    end
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
    @store.length.times do |i|
      @store[i].each do |n|
         new_bucket = n % new_length
         new_store[new_bucket] << n
         new_count += 1
      end
    end
    @store = new_store
  end
end
