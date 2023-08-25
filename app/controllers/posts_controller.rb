class PostsController < ApplicationController

  protect_from_forgery

  def index
    @post = Post.all

    if @post.present?
      render json: Post.all
    else
      render json: {message: "No Posts Present"}
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(set_params)

    if @post.save
      render json: {message:"Post Created", data: @post}
    else
      render json: {errors: @post.errors.full_message}
    end
  end

  def show
    render json: Post.find(params[:user_id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(update_params)
      render json: {message:"UpdatedPost", data: @post}
    else
      render json: {errors: @post.errors.full_message}
    end
  end

  def delete
    @post.destroy
    render json: {message: "This post deleted succesfully"}
  end

  private
  def set_params
    params.permit(:content,:picture,:user_id)
  end


  def update_params
    params.permit(:content,:picture,:user_id)
  end
end
