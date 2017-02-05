class GraphGenerator
  attr_reader :output_filename, :output_path, :directed, :weighted,
                :allow_negative_weights, :v_min_limit, :v_max_limit,
                :e_min_limit, :e_max_limit

  attr_accessor :file, :vertices, :edges

  def initialize(args={})
    @output_path =            args[:output_path] || file_path
    @output_filename =        args[:output_filename] || filename
    @directed =               args[:directed] || false
    @weighted =               args[:weighted] || false
    @allow_negative_weights = args[:allow_negative_weights] || false
    @v_min_limit =            args[:v_min_limit] || 2
    @v_max_limit =            args[:v_max_limit] || 1000
    @e_min_limit =            args[:e_min_limit] || 1
    @e_max_limit =            args[:e_max_limit] || 10000
    @edges =                  []
    @vertices =               []

    @file =                   open_file
    generate_edges
  end

  def generate!
    begin
      file.puts("#{vertices.max} #{edges.size}")

      edges.each do |edge|
        file.puts(edge.join(' '))
      end
      close_file
      puts "Arquivo gerado com sucesso!"
    rescue => e
      puts "Ocorreu um erro: #{e}"
    end
  end

  private

  def get_vertex
    vertex = rand(v_min_limit..v_max_limit)
    vertices << vertex
    vertex
  end

  def generate_edges
    number_of_edges = rand(e_min_limit..e_max_limit)

    number_of_edges.times do |i|
      line = [get_vertex, get_vertex]
      line << weight if weighted
      edges << line
    end
  end

  def weight
    return nil if weighted
    rand(0..10)
  end

  def filename
    timestamp = Time.now.getlocal.to_i
    "graph_#{timestamp}"
  end

  def file_path
    path = File.expand_path("../../../", __FILE__)
    path += '/graphs'
  end

  def open_file
    file = "#{output_path}/#{output_filename}"
    file += ".txt" unless file.include? ".txt"
    File.new(file, "w")
  end

  def close_file
    file.close
  end
end
