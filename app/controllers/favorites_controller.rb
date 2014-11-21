class FavoritesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])   
    favorite = current_user.favorites.build(post: @post)
    authorize favorite
    if favorite.save
      flash[:notice] = "Post was favorited."
      redirect_to [@post.topic, @post]
    else
      #TODO test
      flash[:error] = "An error occurred while favoriting the post.  Please try again."
      redirect_to [@post.topic, @post]
    end  
  end

  def destroy
    # Get the post from the params
    # Find the current user's favorite with the ID in the params
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by_post_id(@post.id)
    authorize favorite
    if favorite.destroy
      # Flash success and redirect to @post
      flash[:notice] = "Post was unfavorited."
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "An error occurred while unfavoriting the post.  Please try again."
      redirect_to [@post.topic, @post]
    end
  
  end

end
