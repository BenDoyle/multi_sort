require 'test_helper'

class MultiSortTest < Test::Unit::TestCase
  def setup
    list_data = Array.new(50){TestDocument.new}
    @source_a = TestSource.new(:a, list_data, lambda{|obj|obj.a})
    @source_b = TestSource.new(:b, list_data, lambda{|obj|obj.b})
    @source_c = TestSource.new(:c, list_data, lambda{|obj|obj.c})
  end

  def test_case
    srt = Multisort.new(@source_a, @source_b)
    srt.source(:b).weight = 2
    srt.add(@source_c, 1)
    result = srt.to_a[0...10]

    assert_kind_of Enumerable, result 
    assert_equal 10, result.size
    assert_equal TestDocument, result.first[:doc].class
    assert_equal TestSource,   result.first[:source].class
    assert_equal Hash,   result.first[:other_sources].class
    assert_equal TestSource,   result.first[:other_sources].first.first
    assert_equal Fixnum,   result.first[:other_sources].first.last
  end
end