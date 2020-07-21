# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authorized
  
  def index
    if params[:query].present?
      @posts = Post.search(params[:query]).page(params[:page])
      @query = params[:query]
    else
      @posts = Post.all.page(params[:page])
    end

    render "index"
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params.merge({ user_id: current_user.id }))
    if @post.save
      redirect_to post_url(@post)
    else
      render partial: "form", status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    flash[:success] = "Your post and all its comments have been deleted."
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
