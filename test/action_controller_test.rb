require 'test_helper'

require 'action_controller'

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
end
