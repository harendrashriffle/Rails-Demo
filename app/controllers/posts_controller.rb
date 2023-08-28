class PostsController < ApplicationController

  protect_from_forgery

#--------------------------------INDEX------------------------------------------

  def index
    render json: {message: "Here is your post", data:@current_user.posts.all}
    # @post = Post.find(params[:user_id])

    # if @post.present?
    #   render json: Post.all
    # else
    #   render json: {message: "No Posts Present"}
    # end
  end

#---------------------------------NEW-------------------------------------------

  # def new
  #   @post = Post.new
  # end

#--------------------------------CREATE-----------------------------------------

  def create
    @post = Post.new(set_params)

    if @post.save
      render json: {message:"Post Created", data: @post}
    else
      render json: {errors: @post.errors.full_message}
    end
  end

#---------------------------------SHOW------------------------------------------

  def show
    # render json: Post.find(params[:user_id])
    render json: @current_user.posts.all
  end

#--------------------------------UPDATE-----------------------------------------

  def update
    @post = Post.find(params[:id])

    if @post.update(update_params)
      render json: {message:"UpdatedPost", data: @post}
    else
      render json: {errors: @post.errors.full_message}
    end
  end

#--------------------------------DELETE-----------------------------------------

  def delete
    @post.destroy
    render json: {message: "This post deleted succesfully"}
  end

#----------------------------PRIVATE METHOD-------------------------------------

  private
  def set_params
    params.permit(:content,:picture,:user_id)
  end

  def update_params
    params.permit(:content,:picture,:user_id)
  end
end
