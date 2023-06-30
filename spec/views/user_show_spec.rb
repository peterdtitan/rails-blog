require 'rails_helper'

RSpec.describe 'users/show', type: :view do
  include Rails.application.routes.url_helpers

  let!(:user) { User.create(name: 'Seth', bio: 'Developer', photo: 'photo.jpg', posts_counter: 4) }
  let!(:post1) { user.posts.create(title: 'Post1', text: 'This is my 1st post', comments_counter: 0, id: 1) }
  let!(:post2) { user.posts.create(title: 'Post2', text: 'This is my 2nd post', comments_counter: 0) }
  let!(:post3) { user.posts.create(title: 'Post3', text: 'This is my 3rd post', comments_counter: 0) }
  let!(:post4) { user.posts.create(title: 'Post4', text: 'This is my 4th post', comments_counter: 0) }

  before do
    assign(:user, user)
    render
    puts rendered
  end

  it 'displays the user\'s profile picture' do
    expect(rendered).to have_css('img[src*="photo.jpg"]')
  end

  it 'displays the user\'s username' do
    expect(rendered).to have_content('Seth')
  end

  it 'displays the number of posts the user has written' do
    expect(rendered).to have_content('Posts: 4')
  end

  it 'displays the user\'s bio' do
    expect(rendered).to have_content('Developer')
  end

  it 'displays the first 3 posts' do
    # same with this one
  end

  it 'redirects to the post show page when clicked' do
    # issues with this test, try to fix
  end

  it 'redirects to the user\'s posts index page' do
    expect(rendered).to have_link('Show All Posts', href: user_posts_path(user))
  end
end
