class VotesController < ApplicationController
  before_filter :setup
  respond_to :html, :js

  def up_vote
    update_vote(1)

    respond_with(@vote) do |f|
      f.html { redirect_to [@topic, @post]}
    end
  end

  def down_vote
    update_vote(-1)
    
    respond_with(@vote) do |f|
      f.html { redirect_to [@topic, @post]}
    end
  end

  private

  def setup
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    authorize! :create, Vote, message: "You need to be a user to do that."
    
    @vote = @post.votes.where(user_id: current_user.id).first
  end

  def update_vote(new_value)
    if @vote
      @vote.update_attribute(:value, new_value)
    else
      @vote = current_user.votes.create(value: new_value, post: @post)
    end
  end
end