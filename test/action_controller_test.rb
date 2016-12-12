require 'test_helper'

require 'action_controller'
require 'active_record'
require 'active_support'
require 'blog/app/models/application_record'
require 'blog/app/models/post'
require 'blog/app/controllers/application_controller'
require 'blog/app/controllers/posts_controller'

class ActionControllerTest < Minitest::Test
  class TestController < ActionController::Base
    before_action :before, only: [:show]
    after_action :after, only: [:show]

    def index
      response << 'index'
    end

    def show
      response << 'show'
    end

    private

    def before
      response << 'before'
    end

    def after
      response << 'after'
    end
  end

  def test_cals_index
    controller = TestController.new
    controller.response = []
    controller.process :index

    assert_equal ['index'], controller.response
  end

  def test_callbacks
    controller = TestController.new
    controller.response = []
    controller.process :show

    assert_equal ['before', 'show', 'after'], controller.response
  end

  class Request
    def params
      { 'id' => 1}
    end
  end

  def test_real_controller
    controller = PostsController.new
    controller.request = Request.new
    controller.process :show
    assert_kind_of Post, controller.instance_variable_get(:@post)
  end
end
