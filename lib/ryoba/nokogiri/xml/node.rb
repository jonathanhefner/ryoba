require "uri"

class Nokogiri::XML::Node

  # Equivalent to +.text.strip+, but raises an error if the result is an
  # empty string.
  #
  # @return [String]
  # @raise [Ryoba::Error]
  #   if result is an empty string
  def text!
    result = self.text.strip
    if result.empty?
      raise Ryoba::Error.new("No text in:\n#{self.to_html}")
    end
    result
  end

  HTML_ELEMENT_URI_ATTRIBUTES = {
    "a" => "href",
    "img" => "src",
    "form" => "action",
  }

  # Returns a URI from a specified attribute's value.  If no attribute
  # is specified, an appropriate attribute will be chosen from
  # {HTML_ELEMENT_URI_ATTRIBUTES} using the Node's +name+, if possible.
  # A relative URI will be converted to an absolute URI, based on the
  # Node document's +url+, if possible.
  #
  # @example
  #   xml = Nokogiri::XML(<<-XML, "http://localhost/qux")
  #     <body>
  #       <a href="https://www.example.com/foo">FOO</a>
  #       <div data-src="/bar" />
  #       <p>blah</p>
  #     </body>
  #   XML
  #
  #   xml.at("a").uri                # == URI("https://www.example.com/foo")
  #   xml.at("div").uri("data-src")  # == URI("http://localhost/qux/bar")
  #   xml.at("p").uri                # == nil
  #
  # @param attribute_name [String]
  #   name of the attribute to return as a URI
  # @return [URI, nil]
  def uri(attribute_name = nil)
    attribute_name ||= HTML_ELEMENT_URI_ATTRIBUTES[self.name]
    url = self[attribute_name]

    if url
      self.document.url ? URI.join(self.document.url, url) : URI(url)
    end
  end

end
