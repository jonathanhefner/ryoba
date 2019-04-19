require "test_helper"

class NokogiriXmlNodeTest < Minitest::Test

  def test_contentpredicate_with_some_text
    node = make_node(" <div> some text </div> ")
    assert_equal node.content.strip, node.content?
  end

  def test_contentpredicate_with_no_text
    node = make_node(<<-XML)
      <div>
        <div />
        <div></div>
        <div> </div>
      </div>
    XML

    node.search("div").each do |div|
      assert_nil div.content?
    end
  end

  def test_inner_textpredicate_aliases_contentpredicate
    node = make_node("")
    assert_equal :content?, node.method(:inner_text?).original_name
  end

  def test_contentbang_with_some_text
    node = make_node(" <div> some text </div> ")
    assert_equal node.content.strip, node.content!
  end

  def test_contentbang_with_no_text
    node = make_node(<<-XML)
      <div>
        <div />
        <div></div>
        <div> </div>
      </div>
    XML

    node.search("div").each do |div|
      assert_raises(Ryoba::Error) { div.content! }
    end
  end

  def test_textbang_aliases_contentbang
    node = make_node("")
    assert_equal :content!, node.method(:text!).original_name
  end

  def test_inner_textbang_aliases_contentbang
    node = make_node("")
    assert_equal :content!, node.method(:inner_text!).original_name
  end

  def test_matchbang_success
    node = make_node('<div id="good" />').child
    assert_equal node, node.matches!("#good")
  end

  def test_matchbang_failure
    node = make_node('<div id="good" />').child
    assert_raises(Ryoba::Error) { node.matches!("#bad") }
  end

  def test_uri_relative
    relative = "/foo"
    expected = URI(relative)

    assert_node_uri expected, relative
  end

  def test_uri_relative_to_absolute
    relative = "/foo"
    base = "http://localhost"
    expected = URI.join(base, relative)

    assert_node_uri expected, relative, base
  end

  def test_uri_absolute
    absolute = "http://localhost/foo"
    base = "http://example.com"
    expected = URI(absolute)

    assert_node_uri expected, absolute, base
  end

  def test_uri_from_appropriate_html_attribute
    expected = URI("/foo")

    html = Nokogiri::XML::Node::HTML_ELEMENT_URI_ATTRIBUTES.map do |el, attr|
      "<#{el} #{attr}=\"#{expected}\" />"
    end.join

    make_node(html).children.each do |node|
      assert_equal expected, node.uri
    end
  end

  def test_uri_missing
    html = Nokogiri::XML::Node::HTML_ELEMENT_URI_ATTRIBUTES.keys.
      map{|el| "<#{el}/>" }.join(" ") + " <div/>"

    make_node(html).children.each do |node|
      assert_nil node.uri
    end
  end

  private

  def assert_node_uri(expected, attribute_value, document_url = nil)
    xml = "<div data-uri=\"#{attribute_value}\" />"
    node = Nokogiri::XML::Document.parse(xml, document_url).child
    assert_equal expected, node.uri("data-uri")
  end

end
