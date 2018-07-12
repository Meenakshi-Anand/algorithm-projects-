require_relative 'graph'
require 'set'
# Implementing topological sort using both Khan's and Tarian's algorithms
#
# def topological_sort(vertices)
#   result, queued = [], []
#
#   vertices.each do |vertex|
#     queued.push(vertex) if vertex.in_edges.empty?
#   end
#
#   while queued.length != 0
#     shifted = queued.shift
#     result.push(shifted)
#
#     until shifted.out_edges.empty?
#       current_edge = shifted.out_edges.pop
#       if current_edge.to_vertex.in_edges.length == 1
#         queued.push(current_edge.to_vertex)
#       end
#       current_edge.destroy!
#     end
#   end
#
#  # to check for cycles
#   return [] unless result.length == vertices.length
#   result
# end

#tarjans without cycle catching
#
#
# def topological_sort(vertices)
#   order = []
#   explored =  Set.new
#   verticies.each do |vertex|
#     dfs!(order,explored,vertex) unless explored.include?(vertex)
#   end
#   order
# end
#
# def dfs!(order,explored,vertex)
#   explored.add(vertex)
#
#   vertex.out_edges.each do |edges|
#     to_vertex = edges.to_vertex
#     dfs!(order,explored,to_vertex) unless explored.include?(vertex)
#   end
#
#   order.unshift(vertex)
# end


#cycle catching tarjans algo


def topological_sort(vertices)
  order = []
  explored =  Set.new
  temp = Set.new
  cycle = false
  vertices.each do |vertex|
    cycle = dfs!(order,explored,vertex,temp,cycle) unless explored.include?(vertex)
    return [] if cycle
  end
  order
end

def dfs!(order,explored,vertex,temp,cycle)
  return true if temp.include?(vertex)
  temp.add(vertex)
  vertex.out_edges.each do |edges|
    to_vertex = edges.to_vertex
    cycle = dfs!(order,explored,to_vertex,temp,cycle) unless explored.include?(to_vertex)
    return true if cycle
  end
  explored.add(vertex)
  temp.delete(vertex)
  order.unshift(vertex)
  false
end
