class SessionsController < ApplicationController
  before_action :findusers, only: [:create]
  def new; end

  def create
    if @user.authenticate params[:session][:password]
      log_in @user
      if params[:session][:remember_me] == Settings.session_numbers
        remember @user
      else
        forget @user
      end
      redirect_to @user
    else
      flash.now[:danger] = t "invalid_info"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def findusers
    @user = User.find_by email: params[:session][:email].downcase
    return if @user

    flash.now[:danger] = t "invalid_info"
    render :new
  end
end
