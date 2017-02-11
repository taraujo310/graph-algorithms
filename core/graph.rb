require_relative 'structure_strategies/adjacency_list.rb'

class Graph
  attr_accessor :structure
  def initialize(filepath, strategy = :adjacency_list)
    @structure = strategy_factory(strategy, filepath)
  end

  def to_s
    structure.to_s
  end

  private
  def strategy_factory(option, filepath)
    AdjacencyList.new(filepath)
  end
end
