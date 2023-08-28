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
    render json: {current_user:@current_user, current_user_post:@current_user.posts.all}
  end

#--------------------------------UPDATE-----------------------------------------

  def update
    @user = User.find(params[:id])

    if @user.update(update_params)
      render json: {message:"UpdatedUser", data: @user}
    else
      render json: {errors: @user.errors.full_message}
    end
  end

#--------------------------------DELETE-----------------------------------------

  def delete
    @current_user.destroy
    render json: {message: "User Account deleted succesfully"}
  end

#--------------------------FOLLOW AND UNFOLLOW----------------------------------

def follow
  @user = User.find(params[:id])
  current_user.followees << @user
  redirect_back(fallback_location: users_posts(@user))
end

def unfollow
  @user = User.find(params[:id])
  current_user.followed_users.find_by(followee_id: @user.id).destroy
  redirect_back(fallback_location: users_posts(@user))
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
