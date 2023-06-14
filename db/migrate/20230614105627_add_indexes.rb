class AddIndexes < ActiveRecord::Migration[7.0]
  def change
    add_index 'comments', ['author_id'], name: 'index_comment_on_author_id'
    add_index 'comments', ['post_id'], name: 'index_comment_on_post_id'
    add_index 'likes', ['author_id'], name: 'index_like_on_author_id'
    add_index 'likes', ['post_id'], name: 'index_like_on_post_id'
    add_index 'posts', ['author_id'], name: 'index_post_on_author_id'
  end
end
