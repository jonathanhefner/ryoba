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

  def test_uri_all_relative
    expected = URI("/foo")

    make_nodes_with_uri(expected).each do |node|
      assert_equal expected, node.uri
    end
  end

  def test_uri_all_relative_to_absolute
    base = "http://localhost"
    relative = "/foo"
    expected = URI.join(base, relative)

    make_nodes_with_uri(relative, base).each do |node|
      assert_equal expected, node.uri
    end
  end

  def test_uri_all_absolute
    base = "http://example.com"
    expected = URI("http://localhost/foo")

    make_nodes_with_uri(expected, base).each do |node|
      assert_equal expected, node.uri
    end
  end

  def test_uri_all_missing
    node = make_node('<a/> <img/> <form/> <div/>')

    node.children.each do |no_uri|
      assert_nil no_uri.uri
    end
  end

  private

  def make_nodes_with_uri(uri, document_uri = nil)
    xml = <<-XML
      <a href="#{uri}" />
      <img src="#{uri}" />
      <form action="#{uri}" />
    XML

    Nokogiri::XML::Document.parse(xml, document_uri && document_uri.to_s).
      children.reject(&:text?)
  end

end
