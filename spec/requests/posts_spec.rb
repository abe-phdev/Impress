require 'rails_helper'

RSpec.describe "Posts", type: :request do

  describe "GET/index" do
    let!(:posts) { create_list(:post, 10) }
    it "displays all the list of posts" do
      get "/"
      expect(assigns(:posts)).to eq posts
    end
  end

  describe "/posts/new" do
    it 'succeeds' do
      get new_post_path
      expect(response).to render_template(:new)
      expect(response.status).to eq 200
    end
  end

  describe "/posts/create" do
    def create_post(title, body)
      post posts_path, params: {
        post: {
          title: title,
          body: body
        }
      }
    end

    context "with valid params" do
      let(:title) { "Sample Title" }
      let(:body) { "Sample body" }

      it 'create a post' do
        expect do
          create_post(title, body)
        end.to change { Post.count}.by(1)

        expect(response).to have_http_status(:redirect)
      end
    end

    context "with invalid params" do
      it 'fails to create a post' do
        expect{ create_post("", "") }.not_to change { Post.count}
        expect(Post.count).to eq(0)
        expect(response).to have_http_status(:success)
      end
    end
  end
end
