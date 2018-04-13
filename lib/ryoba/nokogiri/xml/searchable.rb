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

end
