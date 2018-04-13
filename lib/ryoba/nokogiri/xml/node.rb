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

  # Returns the URI for an HTML link ( +<a>+ ), image ( +<img>+ ), or
  # form ( +<form>+ ).  If possible, a relative URI will be converted to
  # an absolute URI, based on the Node document's +url+ attribute.
  #
  # @return [URI, nil]
  def uri
    url = case self.name
      when "a"
        self["href"]
      when "img"
        self["src"]
      when "form"
        self["action"]
      end

    if url
      self.document.url ? URI.join(self.document.url, url) : URI(url)
    end
  end

end
