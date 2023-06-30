require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { User.create!(name: 'Test User', posts_counter: 0) }

  describe 'GET /users/:user_id/posts' do
    it 'assigns the requested user as @user' do
      get user_posts_path(user)
      expect(assigns(:user)).to eq(user)
    end

    it 'returns a successful response' do
      get user_posts_path(user)
      expect(response).to be_successful
    end

    it 'renders the index template' do
      get user_posts_path(user)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /users/:user_id/posts/:id' do
    context 'when the post exists' do
      let(:post) { user.posts.create!(title: 'Test Post', likes_counter: 0, comments_counter: 0) }

      it 'assigns the requested user as @user' do
        get user_post_path(user, post)
        expect(assigns(:user)).to eq(user)
      end

      it 'assigns the requested post as @post' do
        get user_post_path(user, post)
        expect(assigns(:post)).to eq(post)
      end

      it 'returns a successful response' do
        get user_post_path(user, post)
        expect(response).to be_successful
      end

      it 'renders the show template' do
        get user_post_path(user, post)
        expect(response).to render_template(:show)
      end
    end

    context 'when the post does not exist' do
      it 'redirects to the user posts list' do
        get user_post_path(user, -1)
        expect(response).to redirect_to(user_posts_path(user))
      end
    end
  end
end
