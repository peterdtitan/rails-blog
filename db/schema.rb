ActiveRecord::Schema[7.0].define(version: 2023_06_14_074556) do
  create_table "comments", force: :cascade do |t|
    t.integer "authorId"
    t.integer "postId"
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.text "authorId"
    t.integer "postId"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.integer "author_id"
    t.string "title"
    t.string "text"
    t.integer "comment_counter"
    t.integer "likes_counter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "photo"
    t.string "bio"
    t.integer "posts_counter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
