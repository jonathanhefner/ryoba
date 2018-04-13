module Nokogiri::XML::Searchable

  # Like +Searchable#search+, but raises an exception if there are no
  # results.
  #
  # @param queries [Array<String>]
  # @return [Array<Nokogiri::XML::Element>]
  # @raise [Ryoba::Error]
  #   if all queries yield no results
  def search!(*queries)
    results = self.search(*queries)
    if results.empty?
      raise Ryoba::Error.new("No elements matching #{queries.map(&:inspect).join(" OR ")}")
    end
    results
  end

  # Like +Searchable#at+, but raises an exception if there are no
  # results.
  #
  # @param queries [Array<String>]
  # @return [Nokogiri::XML::Element]
  # @raise [Ryoba::Error]
  #   if all queries yield no results
  def at!(*queries)
    result = self.at(*queries)
    if result.nil?
      raise Ryoba::Error.new("No elements matching #{queries.map(&:inspect).join(" OR ")}")
    end
    result
  end

  # Like +Searchable#ancestors+, but raises an exception if there are no
  # matching ancestors.
  #
  # @param selector [String]
  # @return [Array<Nokogiri::XML::Element>]
  # @raise [Ryoba::Error]
  #   if no ancestors match +selector+
  def ancestors!(selector = nil)
    results = self.ancestors(selector)
    if results.empty?
      raise Ryoba::Error.new("No ancestors matching #{selector.inspect}")
    end
    results
  end

  # Like +Searchable#ancestors+, but returns only the first matching
  # ancestor.
  #
  # @param selector [String]
  # @return [Nokogiri::XML::Element, nil]
  def ancestor(selector = nil)
    self.ancestors(selector).first
  end

end
