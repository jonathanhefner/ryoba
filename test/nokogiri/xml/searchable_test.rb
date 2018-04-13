require "test_helper"

class NokogiriSearchableTest < Minitest::Test

  def test_searchbang_with_some_matching
    node = make_node('<div id="good1" /> <div id="good2" />')

    [
      ["#good1"],
      ["#good1", "#good2"],
      ["#good2", "#good1"],
      ["#good1", "#bad1"],
      ["#bad1", "#good1"],
    ].each do |queries|
      assert_equal node.search(*queries), node.search!(*queries)
    end
  end

  def test_searchbang_with_none_matching
    node = make_node('<div id="good1" />')

    error = assert_raises(Ryoba::Error) { node.search!("#bad1", "#bad2") }
    assert_match "#bad1", error.message
    assert_match "#bad2", error.message
  end

end
