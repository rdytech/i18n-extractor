require_relative 'test_helper'

class HamlParserTest < Minitest::Test

  def setup
    @body = "- if true\n  bar"
  end

  def test_it_can_collect_metadata_about_lines
    tree = I18n::Extractor::HamlParser.new(@body)
    line_metadatas = tree.flattened_values
    assert_equal 2,line_metadatas.size
  end

  # easy api to use index <-> lineno
  def test_it_is_sorted_by_line_numbers
    parser = I18n::Extractor::HamlParser.new(@body)
    line_metadatas = parser.flattened_values
    assert_equal line_metadatas, line_metadatas.sort_by{|m| m[:line]}
  end


end
