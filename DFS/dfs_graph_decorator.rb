require_relative "../core/default_decorators/graph_decorator.rb"
require_relative "dfs_vertex_decorator.rb"

class DFSGraphDecorator < GraphDecorator
  class DuplicateVertexIdentifier < StandardError; end;
  attr_accessor :vertices

  def initialize(graph)
    super(graph)
    @vertices = Set.new
    initialize_vertices
  end

  def neighbors_of(decorated)
    graph.neighbors_of(decorated.vertex).map { |n| find_vertex(n.name) }
  end

  def has_unvisited
    min = vertices.map { |vertex| vertex.in_depth }.min
    min == 0
  end

  def next_unvisited
    vertices.each { |vertex| return vertex if vertex.in_depth == 0 }
  end

  def initialize_vertices
    graph.vertices.each do |vertex|
      vertices << decorate_vertex(vertex)
    end
  end

  def find_vertex(identifier)
    v = vertices.select { |v| v.name == identifier }
    raise DuplicateVertexIdentifier if v.size > 1
    v.first
  end

  def decorate_vertex(vertex)
    DFSVertexDecorator.new(vertex)
  end
end
