class CommentsController < ApplicationController

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comments = @post.comments

    @comment = current_user.comments.build(params[:comment])
    @comment.post = @post
    authorize! :create, @comment, message: "You need be signed in to do that."
    if @comment.save
      flash[:notice] = "Comment submitted."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving your comment. Please try again."
      render 'posts/show' 
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    authorize! :destroy, @comment, message: "You can only delete your comments."
    if @comment.destroy
      flash[:notice] = "Comment successfully deleted."
      redirect_to :back
    else
      flash[:error] = "There was an error deleting the comment."
      redirect_to :back
    end
  end

end