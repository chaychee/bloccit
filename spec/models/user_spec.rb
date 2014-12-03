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

      # Create 2nd user with two posts, two comments
      @user2 = create(:user)
      2.times { create(:post, user: @user2) }
      2.times { create(:comment, user: @user2, post: post) }

      # Create 2nd user with three posts, 3 comments
      @user3 = create(:user)
      3.times { create(:post, user: @user3) }
      3.times { create(:comment, user: @user3, post: post) }

    end

    it "returns users ordered by posts" do
      expect(User.top_rated.take(2)).to eq([@user3, @user2])
    end

    it "stores a `posts_count` on user" do
      user = User.top_rated.first
      expect(user.posts.count).to eq(3)
    end

    it "stores a `comments_count` on user" do
      user = User.top_rated.first
      expect(user.comments.count).to eq(3)
    end
  end


end