class FavoritesController < ApplicationController
  respond_to :html, :js

  def create
    @post = Post.find(params[:post_id])   
    @favorite = current_user.favorites.build(post: @post)
    authorize @favorite
    @favorite.save
 
    respond_with(@favorite) do |format|
      format.html { redirect_to [@post.topic, @post] }
    end
  end

  def destroy
    # Get the post from the params
    # Find the current user's favorite with the ID in the params
    @post = Post.find(params[:post_id])
    @favorite = current_user.favorites.find_by_post_id(@post.id)
    authorize @favorite
    @favorite.destroy

    respond_with(@favorite) do |format|
      format.html { redirect_to [@post.topic, @post] }
    end
  end



end
