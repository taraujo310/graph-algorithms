class VertexDecorator
  attr_accessor :vertex

  def initialize(vertex)
    @vertex = vertex
  end

  def name
    vertex.name
  end  
end
