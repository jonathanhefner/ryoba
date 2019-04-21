require "uri"

class Nokogiri::XML::Document

  # Constructs a URI from the document's +url+ if +url+ is not nil.
  #
  # @example
  #   xml = Nokogiri::XML(<<-XML, "https://www.example.com/foo")
  #     <body>FOO</body>
  #   XML
  #
  #   xml.uri  # == URI("https://www.example.com/foo")
  #
  # @return [URI, nil]
  def uri
    URI(url) if url
  end

end
