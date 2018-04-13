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

  def test_atbang_with_some_matching
    node = make_node('<div id="good1" /> <div id="good2" />')

    [
      ["div"],
      ["#good1", "#good2"],
      ["#good2", "#good1"],
      ["#good1", "#bad1"],
      ["#bad1", "#good1"],
    ].each do |queries|
      assert_equal node.at(*queries), node.at!(*queries)
    end
  end

  def test_atbang_with_none_matching
    node = make_node('<div id="good1" />')

    error = assert_raises(Ryoba::Error) { node.at!("#bad1", "#bad2") }
    assert_match "#bad1", error.message
    assert_match "#bad2", error.message
  end

  def test_ancestorsbang_with_some_matching
    node = make_node('<div id="outer"> <div> <div id="inner" /> </div> </div>')
    inner = node.at("#inner")

    [nil, "div", "#outer"].each do |selector|
      assert_equal inner.ancestors(selector), inner.ancestors!(selector)
    end
  end

  def test_ancestorsbang_with_none_matching
    node = make_node('<div> <div id="inner" /> </div>')
    inner = node.at("#inner")

    error = assert_raises(Ryoba::Error) { inner.ancestors!("#bad") }
    assert_match "#bad", error.message
  end

  def test_ancestor_with_some_matching
    node = make_node('<div id="outer"> <div> <div id="inner" /> </div> </div>')
    inner = node.at("#inner")

    [nil, "div", "#outer"].each do |selector|
      assert_equal inner.ancestors(selector).first, inner.ancestor(selector)
    end
  end

  def test_ancestor_with_none_matching
    node = make_node('<div> <div id="inner" /> </div>')
    inner = node.at("#inner")

    assert_nil inner.ancestor("#bad")
  end

end
