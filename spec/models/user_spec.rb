require 'rails_helper'

describe User do
  
  include TestFactories

  before do
    @post = associated_post
    @user = authenticated_user
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

end