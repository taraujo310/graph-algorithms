require_relative '../vertex.rb'
require 'set'
require 'byebug'
require 'awesome_print'

class AdjacencyList
  attr_accessor :list, :data, :file_ref, :vertices

  def initialize(filepath)
    @file_ref = filepath
    @data = get_data
    @list = create_graph
  end

  def to_s
    ap list
  end

  private
  def get_data
    File.readlines(file_ref)
  end

  def create_graph
    list = initialize_list(number_of_vertices)
    create_relations(list)
  end

  def number_of_vertices
    data.first.split(' ').first.to_i
  end

  def edges
    data.reject{ |e| e == data.first }
  end

  def initialize_list(vertices_amount)
    list = {}
    vertices_amount.times do |i|
      v = Vertex.new("#{i+1}")
      list[v] = []
    end
    list
  end

  def create_relations(list)
    vertices = Set.new list.keys
    edges.each do |relation|
      src, destiny = source_and_destiny(relation, vertices)
      list[src] << destiny
    end
    list
  end

  def source_and_destiny(relation, vertices)
    source_name, destiny_name = relation.split(' ')
    source = vertices.select{ |v| v.name == source_name }.first
    destiny = vertices.select{ |v| v.name == destiny_name }.first
    [source, destiny]
  end
end
