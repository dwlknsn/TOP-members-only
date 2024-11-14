class PostsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create ]

  def index
    # reset_session
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      flash[:notice] = "Post was created successfully."
      redirect_to root_path
    else
      flash[:error] = "Post could not be created."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
