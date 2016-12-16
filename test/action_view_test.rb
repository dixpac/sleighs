require 'test_helper'

class ActionViewTest < Minitest::Test
  def test_render_template
    template = ActionView::Template.new("<p>Hi!</p>", 'test_render_template')
    context = ActionView::Base.new

    assert_equal "<p>Hi!</p>", template.render(context)
  end

  def test_render_variables
    template = ActionView::Template.new("<p><%= @msg %></p>", 'test_render_template')
    context = ActionView::Base.new(msg: 'Hi!')

    assert_equal "<p>Hi!</p>", template.render(context)
  end
end
