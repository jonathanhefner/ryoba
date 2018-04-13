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

end
