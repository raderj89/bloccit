class FavoritesController < ApplicationController

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])

    favorite = current_user.favorites.create(post: @post)

    authorize! :create, Favorite, message: "You need to be signed up to do that."
    if favorite.valid?
      redirect_to [@topic, @post]
    else
      flash[:error] = "Unable to favorite post. Please try again."
      redirect_to new_user_registration_path
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])

    @favorite = current_user.favorites.find(params[:id])

    authorize! :destroy, @favorite, message: "You need to be signed in to do that."
    if @favorite.destroy
      redirect_to [@topic, @post]
    else
      flash[:error] = "Unable to unfavorite post. Please try again."
    end
  end
end
