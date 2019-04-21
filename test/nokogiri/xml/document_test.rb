require "test_helper"

class NokogiriXmlDocumentTest < Minitest::Test

  def test_uri
    url = "http://example.com"
    document = make_node("", url).document
    assert_equal URI(url), document.uri
  end

  def test_uri_missing
    document = make_node("").document
    assert_nil document.uri
  end

end
