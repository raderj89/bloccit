class CommentsController < ApplicationController
  respond_to :html, :js
  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comments = @post.comments

    @comment = current_user.comments.build(params[:comment])
    @comment.post = @post
    @new_comment = Comment.new

    authorize! :create, @comment, message: "You need be signed in to do that."

    if @comment.save
      flash.now[:notice] = "Comment submitted."
    else
      flash.now[:error] = "There was an error saving your comment. Please try again."
    end

    respond_with(@comment) do |f|
      f.html { redirect_to [@topic, @post] }
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])

    @comment = @post.comments.find(params[:id])
    authorize! :destroy, @comment, message: "You can only delete your comments."
    
    if @comment.destroy
      flash.now[:notice] = "Comment successfully deleted."
    else
      flash.now[:error] = "There was an error deleting the comment."
    end

    respond_with(@comment) do |f|
      f.html { redirect_to [@topic, @post] }
    end
  end
end