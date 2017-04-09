require_relative 'core/graph.rb'
require_relative 'DFS/depth_first_search.rb'

g = Core::Graph.new('graphs/graph_1486329915.txt', :adjacency_list)
dfs = DepthFirstSearch.new
puts "Depth First Search"
dfs.search(graph: g, source_identifier: "2")

puts "\n\n>> Depth Table"
dfs.depth_table

puts "\n\n>> Depth Interval Table"
dfs.depth_interval_table
