require 'rails_helper'

RSpec.describe 'Post show page', type: :feature do
  before do
    # Create a user with a post and comments
    @user = User.create!(name: 'John Doe', bio: 'My bio', posts_counter: 0)
    @post = @user.posts.create!(title: 'Test Post', text: 'This is the body of the test post', likes_counter: 0,
                                comments_counter: 0)
    @comment1 = @post.comments.create!(text: 'Test comment', author_id: @user.id)
    @comment2 = @post.comments.create!(text: 'Another test comment', author_id: @user.id)
  end

  it "displays the post's title" do
    visit user_post_path(@user, @post)
    expect(page).to have_content(@post.title)
  end

  it "displays the post's author" do
    visit user_post_path(@user, @post)
    expect(page).to have_content(@user.name)
  end

  it 'displays the number of comments on the post' do
    visit user_post_path(@user, @post)
    expect(page).to have_content(@post.comments.count)
  end

  it 'displays the number of likes on the post' do
    visit user_post_path(@user, @post)
    expect(page).to have_content(@post.likes.count)
  end

  it "displays the post's body" do
    visit user_post_path(@user, @post)
    expect(page).to have_content(@post.text)
  end

  it 'displays the username of each commenter' do
    visit user_post_path(@user, @post)
    expect(page).to have_content(@comment1.user.name)
    expect(page).to have_content(@comment2.user.name)
  end

  it 'displays the comment each commenter left' do
    visit user_post_path(@user, @post)
    expect(page).to have_content(@comment1.text)
    expect(page).to have_content(@comment2.text)
  end
end
