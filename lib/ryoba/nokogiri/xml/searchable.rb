module Nokogiri::XML::Searchable

  # Like +#search+, but raises an exception if there are no results.
  #
  # @example
  #   xml = Nokogiri::XML(<<-XML)
  #     <body>
  #       <div id="a" />
  #       <div id="b" />
  #     </body>
  #   XML
  #
  #   xml.search!("div")  # == NodeSet [div#a, div#b]
  #   xml.search!("img")  # raises exception
  #
  # @param queries [Array<String>]
  # @return [Nokogiri::XML::NodeSet]
  # @raise [Ryoba::Error]
  #   if all queries yield no results
  def search!(*queries)
    results = self.search(*queries)
    if results.empty?
      raise Ryoba::Error.new("No elements matching #{queries.map(&:inspect).join(" OR ")}")
    end
    results
  end

  # Like +#at+, but raises an exception if there are no results.
  #
  # @example
  #   xml = Nokogiri::XML(<<-XML)
  #     <body>
  #       <div id="a" />
  #       <div id="b" />
  #     </body>
  #   XML
  #
  #   xml.at!("div")  # == Node div#a
  #   xml.at!("img")  # raises exception
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

  # Like +#ancestors+, but raises an exception if there are no matching
  # ancestors.
  #
  # @example
  #   xml = Nokogiri::XML(<<-XML)
  #     <body>
  #       <div id="a">
  #         <div id="b">
  #           <img src="cat.jpg">
  #         </div>
  #       </div>
  #     </body>
  #   XML
  #
  #   xml.at("img").ancestors!         # == NodeSet [div#b, div#a, body]
  #   xml.at("img").ancestors!("div")  # == NodeSet [div#b, div#a]
  #   xml.at("img").ancestors!("#a")   # == NodeSet [div#a]
  #   xml.at("img").ancestors!("#z")   # raises exception
  #
  # @param selector [String]
  # @return [Nokogiri::XML::NodeSet]
  # @raise [Ryoba::Error]
  #   if no ancestors match +selector+
  def ancestors!(selector = nil)
    results = self.ancestors(selector)
    if results.empty?
      raise Ryoba::Error.new("No ancestors matching #{selector.inspect}")
    end
    results
  end

  # Like +#ancestors+, but returns only the first matching ancestor.
  #
  # @example
  #   xml = Nokogiri::XML(<<-XML)
  #     <body>
  #       <div id="a">
  #         <div id="b">
  #           <img src="cat.jpg">
  #         </div>
  #       </div>
  #     </body>
  #   XML
  #
  #   xml.at("img").ancestor        # == Node div#b
  #   xml.at("img").ancestor("#a")  # == Node div#a
  #   xml.at("img").ancestor("#z")  # == nil
  #
  # @param selector [String]
  # @return [Nokogiri::XML::Element, nil]
  def ancestor(selector = nil)
    self.ancestors(selector).first
  end

  # Like {ancestors!}, but returns only the first matching ancestor.
  #
  # @example
  #   xml = Nokogiri::XML(<<-XML)
  #     <body>
  #       <div id="a">
  #         <div id="b">
  #           <img src="cat.jpg">
  #         </div>
  #       </div>
  #     </body>
  #   XML
  #
  #   xml.at("img").ancestor!        # == Node div#b
  #   xml.at("img").ancestor!("#a")  # == Node div#a
  #   xml.at("img").ancestor!("#z")  # raises exception
  #
  # @param selector [String]
  # @return [Nokogiri::XML::Element]
  # @raise [Ryoba::Error]
  #   if no ancestors match +selector+
  def ancestor!(selector = nil)
    self.ancestors!(selector).first
  end

end
