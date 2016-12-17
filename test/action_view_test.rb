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

  class TestController < ActionController::Base
    def index
      @var = "value"
    end
  end

  def test_view_assigns
    controller = TestController.new
    controller.index
    assert_equal({ "var" => "value" }, controller.view_assigns)
  end

  def test_render
    request = Rack::MockRequest.new(Rails.application)
    response = request.get("/posts/show?id=1")

    assert_match "<h1>The blog</h1>", response.body
    assert_match "<html>", response.body
  end
end
