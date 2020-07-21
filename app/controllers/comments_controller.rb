# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authorized
  before_action :set_post
  before_action :set_comment, only: [:edit, :destroy, :update]

  def create
    @comment = @post.comments.build(comment_params.merge({ user_id: current_user.id }))

    if @comment.save
      render partial: "posts/comments/show", locals: { comment: @comment }, status: :ok
    else
      render partial: "posts/comments/form", locals: { comment: @comment }, status: :unprocessable_entity
    end
  end

  def edit
    render partial: "posts/comments/form", locals: { comment: @comment }, status: :ok
  end

  def update
    if @comment.update(comment_params.merge({ user_id: current_user.id }))
      render partial: "posts/comments/show", locals: { comment: @comment }, status: :ok
    else
      render partial: "posts/comments/form", locals: { comment: @comment }, status: :unprocessable_entity  
    end
  end

  def destroy
    @comment.destroy
    render partial: "posts/comments/comment_list", status: :ok
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
