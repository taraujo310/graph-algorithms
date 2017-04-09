require_relative "../core/default_decorators/vertex_decorator.rb"

class DFSVertexDecorator < VertexDecorator
  attr_accessor :in_depth, :out_depth, :father

  def initialize(vertex)
    super(vertex)
    @in_depth = 0
    @out_depth = 0
    @father = nil
  end
end
