require 'test_helper'

require 'active_support'
require 'active_record'


class ActiveSupportTest < Minitest::Test
  def setup
    ActiveSupport::Dependecies.autoload_paths = Dir["#{__dir__}/blog/app/*"]
  end

  def test_search_for_file
    file = ActiveSupport::Dependecies.search_for_file('application_controller')
    assert_equal "#{__dir__}/blog/app/controllers/application_controller.rb", file

    file = ActiveSupport::Dependecies.search_for_file('unknown')
    assert_equal nil, file
  end

  def test_case_name
    assert_equal "post", :Post.to_s.underscore
    assert_equal "application_controller", :ApplicationController.to_s.underscore
  end

  def test_load_missing_constants
    Post
  end
end
