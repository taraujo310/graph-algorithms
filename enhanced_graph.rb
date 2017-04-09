require_relative 'DFS_Applications/graph.rb'

g = DFS::Graph.new(graph_file: 'graphs/graph_1486329915.txt', strategy: :adjacency_list)
puts "Grafo é conexo?: #{g.is_connected?}"
puts "Grafo contém ciclos?: #{g.is_cyclic?}"
puts "Quantidade de componentes conexas: #{g.number_of_components}"
