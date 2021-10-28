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
      expect(response.status).to eq 200
    end
  end

  describe "/posts/create" do
    let(:params) do {
      post: {
        title: "Sample Title",
        body: "Sample post body."
      }
    }
    end

    context "with valid params" do
      subject { post posts_path, params: params }

      it 'create a post' do
        expect{ subject }.to change { Post.count }.by(1)
      end
    end

    context "with invalid params" do
      let(:title) { nil }
      let(:body) { nil }

      it 'fails to create a post' do
        post posts_path, params: params
        expect(response.status).to eq 302
      end
    end
  end
end
