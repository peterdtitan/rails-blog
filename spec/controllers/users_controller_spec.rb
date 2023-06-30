require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    it 'assigns all users as @users' do
      user = User.create!(name: 'John Doe', posts_counter: 0)
      get users_path
      expect(assigns(:users)).to eq([user])
    end

    it 'returns a successful response' do
      get users_path
      expect(response).to be_successful
    end

    it 'renders the index template' do
      get users_path
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /users/:id' do
    context 'when the user exists' do
      it 'assigns the requested user as @user' do
        user = User.create!(name: 'John Doe', posts_counter: 0)
        get user_path(user)
        expect(assigns(:user)).to eq(user)
      end

      it 'returns a successful response' do
        user = User.create!(name: 'John Doe', posts_counter: 0)
        get user_path(user)
        expect(response).to be_successful
      end

      it 'renders the show template' do
        user = User.create!(name: 'John Doe', posts_counter: 0)
        get user_path(user)
        expect(response).to render_template(:show)
      end
    end

    context 'when the user does not exist' do
      it 'redirects to the users list' do
        get user_path(-1)
        expect(response).to redirect_to(users_path)
      end
    end
  end
end
