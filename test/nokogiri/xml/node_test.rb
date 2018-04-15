require "test_helper"

class NokogiriXmlNodeTest < Minitest::Test

  def test_textbang_with_some_text
    text = "some text"
    node = make_node(" <div> #{text} </div> ")

    assert_equal text, node.text!
  end

  def test_textbang_with_no_text
    node = make_node(<<-XML)
      <div />
      <div></div>
      <div> </div>
      <div>
        <div> </div>
      </div>
    XML

    assert_raises(Ryoba::Error) { node.text! }
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
