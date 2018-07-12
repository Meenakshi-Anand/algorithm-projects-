class DynamicProgramming

  def initialize
    @blair_cache = {1 => 1, 2 => 2}
    @frog_cache = Hash.new { Set.new }
    @sfc = {}
  end

  def blair_nums(n)
    return @blair_cache[n] unless @blair_cache[n].nil?
    @blair_cache[n] = blair_nums(n-1) + blair_nums(n-2) + ((n - 1) * 2) - 1
  end

  def frog_hops_bottom_up(n)
    frog_cache_builder(n)
  end

  def frog_cache_builder(n)
    cache = {
      1 => [[1]],
      2 => [[1, 1], [2]],
      3 => [[1,1,1], [2, 1], [1, 2], [3]]
    }

    4.upto(n) do |step|
      cache[step] = Array.new
      1.upto(3) do |base|
        # Add each base case for each step from 4 up to n
        cache[step] += cache[step - base].map do |sequence|
          sequence + [base]
        end
      end
   end
   cache[n]
  end

  def frog_hops_top_down(n)
    frog_hops_top_down_helper(n)
  end

  def frog_hops_top_down_helper(n)
    return [[1]] if n == 1
    return [[1, 1], [2]] if n == 2
    return [[1, 1, 1], [1, 2], [2, 1], [3]] if n == 3


    1.upto(3) do |base|
     @frog_cache[n] += frog_hops_top_down_helper(n - base).map do |sequence|
       sequence + [base]
     end
   end

   @frog_cache[n]
  end

  def super_frog_hops(num_stairs, max_stairs)
    return @sfc[[num_stairs, max_stairs]] unless @sfc[[num_stairs, max_stairs]].nil?
    return [[]] if num_stairs == 0

    res = []
    1.upto(max_stairs) do |hop|
      break if hop > num_stairs
      res += super_frog_hops(num_stairs - hop, max_stairs).map do |el|
        el + [hop]
      end

    end
    @sfc[[num_stairs, max_stairs]] = res
  end

  def knapsack(weights, values, capacity)
  @knapsack = { 0 => Array.new(weights.length, 0) }
  knapsack_table(weights, values, capacity)
  # p @knapsack.sort_by {|k,v| k} #checks cache
  @knapsack[capacity].last
end

# Helper method for bottom-up implementation
# you must select the optimum from between these two paradigms: use either the previous item solution at this capacity, or the previous item solution from a smaller bag plus this item's value.
def knapsack_table(weights, values, capacity)
  return 0 if capacity <= 0 || weights.length == 0

  i = weights.length -   1

  @knapsack[capacity] = [] if @knapsack[capacity].nil?

  return @knapsack[capacity][i] if @knapsack[capacity][i]

  prev = knapsack_table(weights[0...i], values[0...i], capacity)
  other = knapsack_table(weights[0...i], values[0...i], capacity - weights[i]) + values[i]
  return prev if weights[i] > capacity
  choices = [prev, other]
  max = choices.max
  @knapsack[capacity][i] = max
  max
end

  def maze_solver(maze, start_pos, end_pos)
  end
end
