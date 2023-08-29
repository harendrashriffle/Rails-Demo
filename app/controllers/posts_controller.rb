class PostsController < ApplicationController

  protect_from_forgery

#--------------------------------INDEX------------------------------------------

  def index
    followed_users_ids = @current_user.followees.pluck(:id)
    post_ids = [@current_user.id] + followed_users_ids
    posts = Post.where(user_id: post_ids).order(created_at: :desc)

    posts_with_details = posts.map do |post|
      {
        post: post,
        comments: post.comments,
        likes: post.likes
      }
    end
    render json: { message: "Here is your and your followings posts", data: posts_with_details }
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
    post_ids = @current_user.id
    posts = Post.where(user_id: post_ids).order(created_at: :desc)
    posts_with_details = posts.map do |post|
      {
        post: post,
        comments: post.comments,
        likes: post.likes
      }
    end

  render json: { message: "Here is your posts", data: posts_with_details }
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

  def destroy
    @post = @current_user.posts.find(params[:id])
    @post.destroy
    render json: {message: "Post deleted succesfully"}
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
