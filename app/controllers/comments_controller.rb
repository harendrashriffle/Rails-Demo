class CommentsController < ApplicationController
  protect_from_forgery

#--------------------------------INDEX------------------------------------------

  def index
    @comment = Comment.all
  end

#---------------------------------NEW-------------------------------------------

  # def new
  #   @comment = Comment.new
  # end

#--------------------------------CREATE-----------------------------------------

  def create
    @comment = Comment.new(set_params)

    if @comment.save
      render json: {message:"Comment Created", data: @comment}
    else
      render json: {errors: @comment.errors.full_message}
    end
  end

#---------------------------------SHOW------------------------------------------

  def show
    render json: Comment.find(params[:id])
  end

#--------------------------------UPDATE-----------------------------------------

  def update
    @comment = Comment.find(params[:id])

    if @comment.update(update_params)
      render json: {message:"Updated Comment", data: @comment}
    else
      render json: {errors: @comment.errors.full_message}
    end
  end

#--------------------------------DELETE-----------------------------------------

  def destroy
    @comment = @current_user.comments.find(params[:id])
    @comment.destroy
    render json: {message: "This comment deleted succesfully"}
  end

#----------------------------PRIVATE METHOD-------------------------------------

  private
  def set_params
    params.permit(:content,:post_id,:user_id)
  end

  def update_params
    params.permit(:content,:post_id,:user_id)
  end
end
