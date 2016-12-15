require 'test_helper'

class ActiveRecordTest < Minitest::Test
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

  def test_where
    relation = Post.where("id = 2").where("title IS NOT NULL")
    post = relation.first

    assert_equal "SELECT * FROM posts WHERE id = 2 AND title IS NOT NULL", relation.to_sql
    assert_equal 2, post.id
  end


  def test_order
    relation = Post.order("created_at DESC").order("id")

    assert_equal "SELECT * FROM posts ORDER BY created_at DESC, id", relation.to_sql
  end
end
