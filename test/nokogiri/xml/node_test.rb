require "test_helper"

class NokogiriXmlNodeTest < Minitest::Test

  def test_textbang_with_some_text
    text = "some text"
    node = make_node(" <div> #{text} </div> ")

    assert_equal text, node.text!
  end

  def test_textbang_with_no_text
    node = make_node(<<-XML)
      <div />
      <div></div>
      <div> </div>
      <div>
        <div> </div>
      </div>
    XML

    assert_raises(Ryoba::Error) { node.text! }
  end

end
