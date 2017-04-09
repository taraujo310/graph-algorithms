require_relative '../core/graph.rb'
require_relative '../DFS/depth_first_search.rb'

module DFS
  class Graph < DepthFirstSearch
    attr_accessor :graph

    def initialize(args)
      super
      @graph = Core::Graph.new(args[:graph_file], args[:strategy])
    end

    def search(args)
      super
    end

    def is_connected?
      search(graph: @graph)
      @component_counter == 1
    end

    def is_cyclic?
      search(graph: @graph)
      @number_of_cycles > 0
    end

    def before_visiting_neighbor_again
      @number_of_cycles = 0
    end

    def after_visiting_neighbor_again
      @number_of_cycles += 1
    end

    def number_of_components
      @component_counter
    end

    def before_external_search
      @component_counter = 0
    end

    def before_search
      @component_counter += 1
    end
  end
end
