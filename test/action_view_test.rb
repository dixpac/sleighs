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

  def test_render_with_yield
    template = ActionView::Template.new("<p><%= yield %></p>",
                                        'test_render_yield')
    context = ActionView::Base.new

    assert_equal "<p>yielded</p>", template.render(context) { 'yielded' }
  end

  def test_render_with_link_to
    template = ActionView::Template.new("<%= link_to 'title', '/url' %>",
                                        'test_render_yield')
    context = ActionView::Base.new

    assert_equal "<a href=\"/url\">title</a>", template.render(context)
  end

  def test_find_template
    file = "#{__dir__}/blog/app/views/posts/index.html.erb"
    template1 = ActionView::Template.find(file)
    template2 = ActionView::Template.find(file)
    assert_same template1, template2
  end
end
