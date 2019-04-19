require "uri"

class Nokogiri::XML::Node

  # Equivalent to +.content.strip+, but returns nil if the result is an
  # empty string.
  #
  # @example
  #   xml = Nokogiri::XML(<<-XML)
  #     <body>
  #       <h1>
  #         Headline 1
  #       </h1>
  #       <h2> Headline 2 </h2>
  #       <h3> </h3>
  #     </body>
  #   XML
  #
  #   xml.at("h1").content?  # == "Headline 1"
  #   xml.at("h2").content?  # == "Headline 2"
  #   xml.at("h3").content?  # == nil
  #
  # @return [String, nil]
  def content?
    result = self.content.strip
    result unless result.empty?
  end

  alias_method :inner_text?, :content?

  # Equivalent to +.content.strip+, but raises an error if the result is
  # an empty string.
  #
  # @example
  #   xml = Nokogiri::XML(<<-XML)
  #     <body>
  #       <h1>
  #         Headline 1
  #       </h1>
  #       <h2> Headline 2 </h2>
  #       <h3> </h3>
  #     </body>
  #   XML
  #
  #   xml.at("h1").content!  # == "Headline 1"
  #   xml.at("h2").content!  # == "Headline 2"
  #   xml.at("h3").content!  # raise error
  #
  # @return [String]
  # @raise [Ryoba::Error]
  #   if result is an empty string
  def content!
    result = self.content.strip
    if result.empty?
      raise Ryoba::Error.new("No text in:\n#{self.to_html}")
    end
    result
  end

  alias_method :inner_text!, :content!
  alias_method :text!, :content!

  # Like +Node#matches?+, but returns the Node if +selector+ matches,
  # and raises an error otherwise.
  #
  # @example
  #   xml = Nokogiri::XML(<<-XML)
  #     <body>
  #       <div id="a" class="c" />
  #       <div id="b" />
  #     </body>
  #   XML
  #
  #   xml.at("#a").matches(".c")!  # == Node div#a.c
  #   xml.at("#b").matches(".c")!  # raise error
  #
  # @param selector [String]
  # @return [self]
  # @raise [Ryoba::Error]
  #   if Node does not match +selector+
  def matches!(selector)
    if !self.matches?(selector)
      abbreviated = self.to_html[/[^>]+>/]
      raise Ryoba::Error.new("Node #{abbreviated} does not match #{selector.inspect}")
    end
    self
  end

  HTML_ELEMENT_URI_ATTRIBUTES = {
    "a" => "href",
    "img" => "src",
    "form" => "action",
  }

  # Builds a URI from a specified attribute.  If no attribute is
  # specified, an element-appropriate attribute will be chosen from
  # {HTML_ELEMENT_URI_ATTRIBUTES}, if possible.  Relative URIs will be
  # converted to absolute URIs using the Node document's +url+, if
  # possible.
  #
  # @example
  #   xml = Nokogiri::XML(<<-XML, "http://localhost/qux/")
  #     <body>
  #       <a href="https://www.example.com/foo">FOO</a>
  #       <img src="/bar" />
  #       <div data-src="baz" />
  #       <p>blah</p>
  #     </body>
  #   XML
  #
  #   xml.at("a").uri                # == URI("https://www.example.com/foo")
  #   xml.at("img").uri              # == URI("http://localhost/bar")
  #   xml.at("div").uri("data-src")  # == URI("http://localhost/qux/baz")
  #   xml.at("p").uri                # == nil
  #
  # @param attribute_name [String]
  # @return [URI, nil]
  def uri(attribute_name = nil)
    attribute_name ||= HTML_ELEMENT_URI_ATTRIBUTES[self.name]
    url = self[attribute_name]

    if url
      self.document.url ? URI.join(self.document.url, url) : URI(url)
    end
  end

end
