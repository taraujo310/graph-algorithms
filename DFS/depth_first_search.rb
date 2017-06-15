require_relative 'dfs_graph_decorator.rb'

class DepthFirstSearch
  class NoGraphError < StandardError; end

  attr_accessor :source, :graph, :clock

  def initialize(args=nil)
    @source = nil
    @graph = nil
    @clock = 0
  end

  def search(args)
    raise NoGraphError if args[:graph].nil?
    @graph = DFSGraphDecorator.new(args[:graph])
    @source = graph.find_vertex(args[:source_identifier]) || graph.vertices.first

    before_external_search

    while(@source.in_depth == 0 || @graph.has_unvisited)
      before_search

      sub_root = @source.in_depth == 0 ? @source : @graph.next_unvisited
      depth_first_search(sub_root)

      after_search
    end

    after_external_search
  end

  def depth_table
    _depth_table
  end

  def depth_interval_table
    _depth_interval_table
  end

  protected
  def depth_first_search(vertex)
    @clock += 1
    vertex.in_depth = @clock

    @graph.neighbors_of(vertex).each do |neighbor|
      if neighbor.in_depth == 0
        before_first_visiting_neighbor

        puts "Visiting (#{vertex.name}, #{neighbor.name})"
        neighbor.father = vertex
        depth_first_search(neighbor)

        after_first_visiting_neighbor
      else
        if neighbor.out_depth == 0 && neighbor != vertex.father
          before_visiting_neighbor_again

          puts "Visiting (#{vertex.name}, #{neighbor.name})"

          after_visiting_neighbor_again
        end
      end
    end

    @clock += 1
    vertex.out_depth = @clock
  end

  def before_external_search; end;
  def after_external_search; end;
  def before_search; end;
  def after_search; end;
  def before_first_visiting_neighbor; end;
  def after_first_visiting_neighbor; end;
  def before_visiting_neighbor_again; end;
  def after_visiting_neighbor_again; end;

  private
  def _depth_table
    table, line, columns = [], [], [@clock.digits.size, 4].max
    line << "#ID"
    line << @graph.vertices.map { |v| "#{v.name.ljust(columns)}" }
    table << line.flatten

    line = []
    line << "IN"
    line << @graph.vertices.map { |v| sprintf("%.#{columns}d", v.in_depth)  }
    table << line.flatten

    line = []
    line << "OUT"
    line << @graph.vertices.map { |v| sprintf("%.#{columns}d", v.out_depth) }
    table << line.flatten

    print_intervals(table)
  end

  def _depth_interval_table
    table, first_line = [], []
    columns = [@clock.digits.size, vertex_largest_name, 4].max
    first_line << "#{'t'.ljust(columns)}"
    first_line << (1..@clock).to_a.map { |i| sprintf("%.#{columns}d", i) }
    table << first_line

    @graph.vertices.each do |vertex|
      line = []

      (@clock+1).times do |counter|
        if ((vertex.in_depth)..(vertex.out_depth)).to_a.include?(counter) && counter != 0
          line << "#{'*'*columns}"
        elsif counter == 0
          line << vertex.name
        else
          line << "#{' '.ljust(columns)}"
        end
      end
      table << line
    end
    print_intervals(table)
  end

  def vertex_largest_name
    largest = 0
    @graph.vertices.each do |v|
      largest = v.name.size if largest < v.name.size
    end
    largest
  end

  def print_intervals(table)
    table.each do |line|
      puts line.join("\t")
    end
  end
end
