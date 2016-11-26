require 'test_helper'

require 'active_record'
require 'blog/app/models/application_record'
require 'blog/app/models/post'

class ActiveRecordTest < Minitest::Test
  def setup
    Post.establish_connection(
      database: "#{__dir__}/blog/db/development.sqlite3")
  end

  def test_initialize
    post = Post.new(id: 1, title: 'Cooler', body: 'Super cool post!')

    assert_equal 1, post.id
    assert_equal 'Cooler', post.title
    assert_equal 'Super cool post!', post.body
  end

  def test_find
    post = Post.find(1)

    assert_kind_of Post, post
    assert_equal 1, post.id
    assert_equal 'Space post', post.title
    assert_equal 'Kevin Spacey is emperor of the space', post.body
  end

  def test_all
    post = Post.all.first

    assert_kind_of Post, post
    assert_equal 1, post.id
    assert_equal 'Space post', post.title
    assert_equal 'Kevin Spacey is emperor of the space', post.body
  end

  def test_execute_sql
    rows = Post.connection.execute("SELECT * FROM posts;")
    row = rows.first

    assert_kind_of Array, rows
    assert_kind_of Hash, row
    assert_equal [:id, :title, :body, :created_at, :updated_at], row.keys
  end
end
