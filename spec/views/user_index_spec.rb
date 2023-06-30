require 'rails_helper'

RSpec.describe 'users/index', type: :view do
  let!(:user1) { User.create(name: 'Seth', bio: 'Developer', photo: 'photo.jpg', posts_counter: 4) }
  let!(:user2) { User.create(name: 'Anas', bio: 'Pentester', photo: 'photo.jpg', posts_counter: 10) }

  before do
    assign(:users, [user1, user2])
    render
  end

  it 'displays the username of all other users' do
    expect(rendered).to have_content('Seth')
    expect(rendered).to have_content('Anas')
  end

  it 'displays the profile picture for each user' do
    expect(rendered).to have_css('img[src*="photo.jpg"]', count: 2)
  end

  it 'displays the number of posts each user has written' do
    expect(rendered).to have_content('Posts: 4', count: 1)
    expect(rendered).to have_content('Posts: 10', count: 1)
  end

  it 'redirects to the user show page when clicked' do
    expect(rendered).to have_link('Seth', href: user_path(user1))
    expect(rendered).to have_link('Anas', href: user_path(user2))
  end
end
