class CommentsController < ApplicationController
  protect_from_forgery
  def create
    @comment = Comment.new(set_params)

    if @comment.save
      render json: {message:"Comment Created", data: @comment}
    else
      render json: {errors: @comment.errors.full_message}
    end
  end

  def show
    render json: Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update(update_params)
      render json: {message:"Updated Comment", data: @comment}
    else
      render json: {errors: @comment.errors.full_message}
    end
  end

  private
  def set_params
    params.permit(:content,:post_id,:user_id)
  end

  def update_params
    params.permit(:content,:post_id,:user_id)
  end
end
