require "prawn"
class UsersController < ApplicationController

  skip_before_action :authenticate_request, only: [:create, :user_login]

  protect_from_forgery

#-----------------------------USER LOGIN----------------------------------------

  def user_login
    if user=User.find_by(email: params[:email], password_digest: params[:password_digest])
      token= jwt_encode(user_id: user.id)
      render json: { message: "Logged In Successfully..", token: token }
    else
      render json: { error: "Please Check your Email And Password....." }
    end
  end

#--------------------------------INDEX------------------------------------------

  # def index
  #   @user = User.all

  #   if @user.present?
  #     # render json: User.all.to_json(only: [:email, :name])
  #     render json: User.all
  #   else
  #     render json: {message: "No Users Present"}
  #   end
  # end

#---------------------------------NEW-------------------------------------------

  # def new
  #   @user = User.new
  # end

#--------------------------------CREATE-----------------------------------------

  def create
    @user = User.new(set_params)

    if @user.save
      render json: {message:"User Created", data: @user}
    else
      render json: {errors: @user.errors.full_messages}
    end
  end

#---------------------------------SHOW------------------------------------------

  def show
    render json: @current_user
  end

#--------------------------------UPDATE-----------------------------------------

  def update
    if @current_user.update(update_params)
      render json: { message: "User profile updated", data: @current_user }
    else
      render json: { errors: @current_user.errors.full_messages }
    end
  end

#--------------------------------DELETE-----------------------------------------

  def destroy
    # user = User.delete(@current_user.id)
    @current_user.delete
    render json: {message: "User Account deleted succesfully"}
  end

#--------------------------FOLLOW AND UNFOLLOW----------------------------------

  def follow
    @user = User.find(params[:id])
    current_user.followees << @user
    redirect_to(users_path(@current_user))
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.followed_users.find_by(followee_id: @user.id).destroy
    redirect_to(users_path(@current_user))
  end

#-----------------------FOLLOWERS AND FOLLOWING----------------------------------

 def followers
    follower_ids = @current_user.followed_users.pluck(:follower_id)
    followers = User.where(id: follower_ids)

    render json: { message: "Followers of current user", data: followers }
  end

  def following
    following_ids = @current_user.followees.pluck(:followee_id)
    following_users = User.where(id: following_ids)

    render json: { message: "Users followed by current user", data: following_users }
  end

#----------------------------PRIVATE METHOD-------------------------------------

  private
    def set_params
      params.permit(:name,:email,:password_digest)
    end

    def update_params
      params.permit(:name,:email,:password_digest)
    end

end
