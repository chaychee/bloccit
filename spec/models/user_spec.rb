require 'rails_helper'

describe User do
  
  before do
    @post = create(:post)
    @user = create(:user)
  end


  describe "#favorited(post)" do
    it "returns 'nil' if the user has not favorited the post" do
      expect(@user.favorited(@post)).to eq(nil)  
    end

    it "returns the approriate favorited if it exists" do
      favorite = @post.favorites.create(user: @user)
      expect(@user.favorited(@post)).to eq(favorite)
    end
  end


  describe ".top_rated" do
 
    before do
      # Create user with one post, one comment
      @user1 = create(:user)
      post = create(:post, user: @user1)
      create(:comment, user: @user1, post: post)

      # Create 2nd user with one post, two comments
      @user2 = create(:user)
      post = create(:post, user: @user2)
      2.times { create(:comment, user: @user2, post: post) }
    end

    it "returns users ordered by comments + posts" do
      expect(User.top_rated).to eq([@user2, @user1])
    end

    it "stores a `posts_count` on user" do
      user = User.top_rated.first
      expect(user.posts.count).to eq(1)
    end

    it "stores a `comments_count` on user" do
      user = User.top_rated.first
      expect(@user2.comments.count).to eq(2)
    end
  end


end