# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.



# Maintain another max_queue, head of that queue will be the max element
# When an element is enqueued
# Check tail of max_queue, if tail is greater than element, then insert at tail
# If tail is less than element, then remove from tail iteratively until max_queue is empty or tail element is greater than or equal to the element
# When an element is dequeued
# Check if its same as max_queue's head, if it is then remove,
# else no action.
# Concept here is: max queue must contain elements in decreasing order,
# any element that will get dequeued before it gets a chance to
# become max must be removed from max queue

require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :store

  def initialize
    @store = RingBuffer.new
    @max = nil
  end

  def enqueue(val)
    @store.push(val)
    if @max.nil? || @max < val
      @max = val
    end
  end

  def dequeue
    val = @store.shift
    if val == @max
      i = 0
      max = 0
      while i < @store.length
        @max = @store[i] if @store[i] > max
        i += 1
      end
    end
  end

  def max
    @max
  end

  def length
    @store.length
  end

end
