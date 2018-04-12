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

end
