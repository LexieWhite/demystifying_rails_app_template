class ApplicationController < ActionController::Base
  def connection
    dbconnection = SQLite3::Database.new 'db/development.sqlite3'
    dbconnection.results_as_hash = true
    dbconnection
  end

  def find_post_by_id(id)
    connection.execute("SELECT * FROM posts WHERE posts.id = ? LIMIT 1", id).first
  end

  def hello_world
    render inline: File.read('app/views/application/hello_world.html')
  end

  def list_posts
    posts = connection.execute('SELECT * FROM posts')
    render 'application/list_posts', locals: {posts: posts}
  end

  def show_post
    post = find_post_by_id(params['id'])
    render 'application/show_post', locals: { post: post }
  end

  def new_post
    render 'application/new_post'
  end

  def create_post
    insert_query = <<-SQL
      INSERT INTO posts (title, author, body, created_at)
      VALUES (?, ?, ?, ?)
    SQL

    connection.execute insert_query,
      params['title'],
      params['body'],
      params['author'],
      Date.current.to_s

      redirect_to '/list_posts'
    end

    def edit_post
      post = find_post_by_id(params['id'])
      render 'application/edit_post', locals: { post: post }
    end

    def update_post
      update_query = <<-SQL
        UPDATE posts
        SET title   = ?,
            body    = ?,
            author  = ?
        WHERE posts.id = ?
      SQL

      connection.execute update_query, params['title'], params['body'], params['author'], params['id']
      redirect_to '/list_posts'
    end

    def delete_post
      connection.execute('DELETE FROM posts WHERE posts.id = ?', params['id'])
      redirect_to '/list_posts'
    end

end
