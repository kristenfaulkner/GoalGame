class SessionsController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.find_by_username(params[:user][:username])
    if !@user
       flash[:errors] = ["Invalid Username"]    
       redirect_to new_user_url
    elsif @user.is_password?(params[:user][:password])
      sign_in(@user)
      redirect_to goals_url
    else
      flash.now[:errors] = ["Invalid password"]
      render :new
    end
  end
  
  def destroy
    sign_out
    redirect_to new_session_url
  end
end