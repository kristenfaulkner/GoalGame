class SessionsController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.find_by_username(params[:user][:username])
    if @user && @user.is_password?(params[:user][:password])
      sign_in(@user)
      redirect_to goals_url
    else
      flash.now[:errors] = ["Invalid Username or password"]
      render :new
    end
  end
  
  def destroy
    sign_out
    redirect_to goals_url
  end
end