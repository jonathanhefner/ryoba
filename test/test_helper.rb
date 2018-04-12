$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "ryoba"

require "minitest/autorun"


class Minitest::Test

  private

  def make_node(xml)
    Nokogiri::XML("<root>#{xml}</root>").at("root")
  end

end
