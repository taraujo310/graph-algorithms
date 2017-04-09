require_relative 'structure_strategies/adjacency_list.rb'

module Core
  class Graph
    attr_accessor :structure
    def initialize(filepath, strategy = :adjacency_list)
      @structure = strategy_factory(strategy, filepath)
    end

    def to_s
      structure.to_s
    end

    def vertices
      structure.vertices
    end

    def present?
      structure.vertices.size > 0
    end

    def neighbors_of(vertex)
      structure.neighbors_of(vertex)
    end

    private
    def strategy_factory(option, filepath)
      AdjacencyList.new(filepath)
    end
  end
end
