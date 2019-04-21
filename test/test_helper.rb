$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "ryoba"

require "minitest/autorun"


class Minitest::Test

  private

  def make_node(xml, document_url = nil)
    Nokogiri::XML("<root>#{xml}</root>", document_url).at("root")
  end

end
