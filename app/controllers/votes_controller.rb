class VotesController < ApplicationController
  before_action :load_post_and_vote

  def up_vote
    update_vote!(1)
    redirect_to :back
  end

  def down_vote
    update_vote!(-1)
    redirect_to :back
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
