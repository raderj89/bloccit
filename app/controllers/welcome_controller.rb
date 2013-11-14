class WelcomeController < ApplicationController
  def index
    @posts = Post.order("rank DESC").limit(5)
    @posts_all_time = Post.order("created_at DESC").order("rank DESC").limit(5)
  end

  def about
  end
end
