class GraphDecorator
  attr_accessor :graph

  def initialize(graph)
    @graph = graph
  end

  def to_s
    graph.to_s
  end

  def vertices
    graph.vertices
  end

  def present?
    graph.present?
  end
end
