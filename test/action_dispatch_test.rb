require 'test_helper'

require 'rack'
require 'active_support'
require 'action_dispatch'
require 'action_controller'
require 'active_record'
require 'action_dispatch/routing/route_set'
require 'action_dispatch/routing/mapper'

require 'blog/app/controllers/application_controller'
require 'blog/app/controllers/posts_controller'
require 'blog/app/models/application_record'
require 'blog/app/models/post'

class ActionDispatchTest < Minitest::Test
  def test_add_route
    routes = ActionDispatch::Routing::RouteSet.new
    route  = routes.add_route 'GET', '/posts', 'posts', 'index'

    assert_equal 'posts', route.controller
    assert_equal 'index', route.action
  end

  def test_find_route
    routes = ActionDispatch::Routing::RouteSet.new
    route  = routes.add_route 'GET', '/posts', 'posts', 'index'
    route  = routes.add_route 'POST', '/posts', 'posts', 'create'
    request = Rack::Request.new(
      "REQUEST_METHOD" => "POST",
      "PATH_INFO" => "/posts",
    )

    route = routes.find_route(request)

    assert_equal 'posts', route.controller
    assert_equal 'create', route.action
  end

  def test_draw
    routes = ActionDispatch::Routing::RouteSet.new
    routes.draw do
      get '/hello', to: 'hello#index'
      root to: 'posts#index'
      resources :posts
    end
    request = Rack::Request.new(
      "REQUEST_METHOD" => "GET",
      "PATH_INFO" => "/posts/new",
    )

    route = routes.find_route(request)

    assert_equal 'posts', route.controller
    assert_equal 'new', route.action
    assert_equal 'new_post', route.name
  end

  def test_call
    routes = ActionDispatch::Routing::RouteSet.new
    routes.draw do
      root to: 'posts#index'
      resources :posts
    end
    env = {
      "REQUEST_METHOD" => "GET",
      "PATH_INFO" => "/posts/new",
    }

    status, header, body = routes.call(env)

    assert_equal 200, status
  end

end
