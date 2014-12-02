class VotesController < ApplicationController
  respond_to :html, :js
  before_action :load_post_and_vote

  def up_vote
    update_vote!(1)
  
    respond_with(@vote) do |format|
      format.html { redirect_to :back }
    end
  end

  def down_vote
    update_vote!(-1)

    respond_with(@vote) do |format|
      format.html { redirect_to :back }
    end
  end

  private

  def update_vote!(vote_value)
    if (@vote)
      authorize @vote, :update?
      @vote.update(value: vote_value)
    else 
      @vote = @post.votes.build(user_id: current_user.id, value: vote_value)
      authorize @vote, :create?
      @vote.save
    end      
  end

  def load_post_and_vote
    @post = Post.find(params[:post_id])
    @vote = @post.votes.where(user_id: current_user.id).first
  end

end
