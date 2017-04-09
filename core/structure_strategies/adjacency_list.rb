require_relative '../vertex.rb'
require 'set'
require 'byebug'
require 'awesome_print'

class AdjacencyList
  attr_accessor :adjacency_list, :data, :file_ref, :vertices

  def initialize(filepath)
    @file_ref = filepath
    @data = File.readlines(@file_ref)
    @adjacency_list = {}
    initialize_adjacency_list

    @vertices = Set.new @adjacency_list.keys
    create_relations
  end

  def to_s
    ap adjacency_list
  end

  def neighbors_of(vertex)
    adjacency_list[vertex]
  end

  private
  def initialize_adjacency_list
    number_of_vertices.times do |i|
      v = Vertex.new("#{i+1}")
      adjacency_list[v] = []
    end
  end

  def number_of_vertices
    data.first.split(' ').first.to_i
  end

  def edges
    data.reject{ |e| e == data.first }
  end

  def create_relations
    edges.each do |relation|
      src, destiny = source_and_destiny(relation)

      if src == destiny
        adjacency_list[src] << destiny unless adjacency_list[src].include? destiny
      else
        adjacency_list[src] << destiny unless adjacency_list[src].include? destiny
        adjacency_list[destiny] << src unless adjacency_list[destiny].include? src
      end
    end
  end

  def source_and_destiny(relation)
    source_name, destiny_name = relation.split(' ')
    source = vertices.select{ |v| v.name == source_name }.first
    destiny = vertices.select{ |v| v.name == destiny_name }.first
    [source, destiny]
  end
end
