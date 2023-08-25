require "prawn"
class UsersController < ApplicationController
  # http_basic_authenticate_with name: "H", password: "1"
  # USERS = { "H" => "1" }
  # before_action :authenticate

  protect_from_forgery


  def user_login
    if user=User.find_by(email: params[:email], password: params[:password])
      token= jwt_encode(user_id: user.id)
      render json: { message: "Logged In Successfully..", token: token }
    else
      render json: { error: "Please Check your Email And Password....." }
    end
  end

  def index
    @user = User.all

    if @user.present?
      # render json: User.all.to_json(only: [:email, :name])
      render json: User.all
    else
      render json: {message: "No Users Present"}
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(set_params)

    if @user.save
      render json: {message:"User Created", data: @user}
    else
      render json: {errors: @user.errors.full_messages}
    end
  end

  def show
    render json: User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(update_params)
      render json: {message:"UpdatedUser", data: @user}
    else
      render json: {errors: @user.errors.full_message}
    end
  end

  def delete
    @user.destroy
    render json: {message: "User deleted succesfully"}
  end


  def download_pdf
    user = User.find(params[:id])
    send_data generate_pdf(user),filename: "#{user.name}.pdf",type: "application/pdf"
  end

  private
    def set_params
      params.permit(:name,:email)
    end

    def update_params
      params.permit(:name,:email)
    end


  private
    def generate_pdf(user)
      Prawn::Document.new do
        text user.name, align: :center
        text "Email: #{user.email}"
      end.render
    end


  # private
  #   def authenticate
  #     authenticate_or_request_with_http_digest do |username|
  #       USERS[username]
  #     end
  #   end
end
