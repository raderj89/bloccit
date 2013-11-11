class TopicsController < ApplicationController
  def index
    @topics = Topic.paginate(page: params[:page], per_page: 10)
  end

  def new
    @topic = Topic.new
    authorize! :create, Topic, message: "You need to be an admin to do that."
  end

  def show
    @topic = Topic.find(params[:id])
    @posts = @topic.posts.paginate(page: params[:page], per_page: 10)
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def create
    @topic = Topic.new(params[:topic])
    if @topic.save
      flash[:notice] = "Topic saved successfully."
      redirect_to @topic
    else
      flash[:error] = "Error creating topic. Please try again."
      render :new
    end
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update_attributes(params[:topic])
      redirect_to @topic
    else
      flash[:error] = "Error saving topic. Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    name = @topic.name
    authorize! :destroy, @topic, message: "You need to be an admin to do that."
    if @topic.destroy
      flash[:notice] = "\"#{name}\" was successfully deleted."
      redirect_to topics_path
    else
      flash[:error] = "There was an error deleting this topic."
      render :show
    end
  end
end
