require 'minitest/autorun'
require 'minitest/filesystem'
require_relative '../core/graph_generator/graph_generator.rb'

class TestGraphGenerator < Minitest::Test
  def setup
    @options = {}
    @options[:output_path] = 'test/support'
    @options[:output_filename] = 'graph_test.txt'
    @graph_generator = GraphGenerator.new(@options)
  end

  def test_generator_should_generate_a_file
    assert_exists "#{@options[:output_path]}/#{@options[:output_filename]}"
  end
end
