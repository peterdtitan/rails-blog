require 'rails_helper'

RSpec.describe 'User post index page', type: :feature do
  before do
    # Create a user with posts and comments
    @user = User.create!(name: 'John Doe', bio: 'My bio', posts_counter: 0)
    @post1 = @user.posts.create!(title: 'Test Post', text: 'This is the body of the test post', likes_counter: 0,
                                 comments_counter: 0)
    @post2 = @user.posts.create!(title: 'Test 2', text: 'This is the body of the second test post', likes_counter: 0,
                                 comments_counter: 0)
    @comment1 = @post1.comments.create!(text: 'Test comment', author_id: @user.id)
    @comment2 = @post1.comments.create!(text: 'Another test comment', author_id: @user.id)
  end

  it "displays the user's profile picture" do
    visit user_posts_path(@user)
    expect(page).to have_css("img[src*='#{@user.photo}']")
  end

  it "displays the user's username" do
    visit user_posts_path(@user)
    expect(page).to have_content(@user.name)
  end

  it 'displays the number of posts the user has written' do
    visit user_posts_path(@user)
    expect(page).to have_content(@user.posts.count)
  end

  it "displays some of the post's body" do
    visit user_posts_path(@user)
    expect(page).to have_content(@post2.text[0..99])
  end

  it 'displays the first comments on a post' do
    visit user_posts_path(@user)
    expect(page).to have_content(@comment1.text)
    expect(page).to have_content(@comment2.text)
  end

  it 'displays how many comments a post has' do
    visit user_posts_path(@user)
    expect(page).to have_content(@post2.comments.count)
  end

  it 'displays how many likes a post has' do
    visit user_posts_path(@user)
    expect(page).to have_content(@post2.likes.count)
  end
end
