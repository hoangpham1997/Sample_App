class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(create new show)
  before_action :load_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @users = User.page(params[:page]).per Settings.per_pages
  end

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "pls_check_activate"
      redirect_to root_url
    else
      flash[:danger] = t "invalid_info"
      render :new
    end
  end

  def update
    if @user.update user_params
      flash[:success] = t "pro_updated"
      redirect_to @user
    else
      render :edit
      flash[:danger] = t "fail_update"
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "user_del"
    else
      flash[:danger] = t "invalid_info"
    end
    redirect_to users_url
  end

  def authenticated? attribute, token
    digest = send("#{attribute}_digest")
    return false unless digest

    BCrypt::Password.new(digest).is_password? token
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
                                 :password_confirmation
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "pls_log_in"
    redirect_to login_url
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "invalid_info"
    redirect_to root_url
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
