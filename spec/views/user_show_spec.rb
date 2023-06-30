require 'rails_helper'

RSpec.describe 'users/show', type: :feature do
  before do
    @user = User.create!(name: 'Seth', bio: 'Developer', photo: 'photo.jpg', posts_counter: 4)
    @post1 = @user.posts.create!(title: 'Post1', text: 'This is my 1st post', comments_counter: 0, likes_counter: 0)
    @post2 = @user.posts.create!(title: 'Post2', text: 'This is my 2nd post', comments_counter: 0, likes_counter: 0)
    @post3 = @user.posts.create!(title: 'Post3', text: 'This is my 3rd post', comments_counter: 0, likes_counter: 0)
    @post4 = @user.posts.create!(title: 'Post4', text: 'This is my 4th post', comments_counter: 0, likes_counter: 0)
  end

  it 'displays the user\'s profile picture' do
    visit user_path(@user)
    expect(page).to have_css("img[src*='#{@user.photo}']")
  end

  it 'displays the user\'s username' do
    visit user_path(@user)
    expect(page).to have_content(@user.name.to_s)
  end

  it 'displays the number of posts the user has written' do
    visit user_path(@user)
    expect(page).to have_content(@user.posts_counter.to_s)
  end

  it 'displays the user\'s bio' do
    visit user_path(@user)
    expect(page).to have_content(@user.bio.to_s)
  end

  it 'displays the first 3 posts' do
    visit user_posts_path(@user)

    expect(page).to have_content(@post2.title)
    expect(page).to have_content(@post3.title)
    expect(page).to have_content(@post4.title)
  end

  it 'redirects to the post show page when clicked' do
    visit user_path(@user)
    expect(page).to have_link('Post4', href: user_post_path(@user, @post4))
  end

  it 'redirects to the user\'s posts index page' do
    visit user_path(@user)

    expect(page).to have_link('Show All Posts', href: user_posts_path(@user))
  end
end
