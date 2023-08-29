class LikesController < ApplicationController
  protect_from_forgery

#--------------------------------INDEX------------------------------------------

  def index
    @like = Like.all
  end

#---------------------------------NEW-------------------------------------------

  # def new
  #   @like = Like.new
  # end

#--------------------------------CREATE-----------------------------------------

  def create
    @like = Like.new(set_params)

    if @like.save
      render json: {message:"You likes", data: @like}
    else
      render json: {errors: @like.errors.full_message}
    end
  end

#---------------------------------SHOW------------------------------------------

  def show
    render json: Like.find(params[:id])
  end

#--------------------------------UPDATE-----------------------------------------

  def update
    # @like = @current_user.likes.find(params[:id])
    @like = Like.find(params[:id])

    if @like.update(update_params)
      render json: {message:"Updated like", data: @like}
    else
      render json: {errors: @like.errors.full_message}
    end
  end

#--------------------------------DELETE-----------------------------------------

  def destroy
    # @like = @current_user.likes.find(params[:id])
    @like.destroy
    render json: {message: "This like deleted succesfully"}
  end

#----------------------------PRIVATE METHOD-------------------------------------

  private
  def set_params
    params.permit(:expression,:post_id,:user_id)
  end

  def update_params
    params.permit(:expression,:post_id,:user_id)
  end
end
