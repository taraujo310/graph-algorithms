require_relative 'core/graph_generator/graph_generator.rb'
options = {
  v_max_limit: 10,
  e_max_limit: 10,
}

GraphGenerator.new(options).generate!
