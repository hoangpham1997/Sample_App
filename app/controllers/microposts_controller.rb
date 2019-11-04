class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :find_post, only: :destroy

  def create
    in_create
    if @micropost.save
      flash[:success] = t "micro_created"
    else
      @feed_items = current_user.feed.page params[:page]
      flash[:danger] = t "micro_failed"
    end
    redirect_to root_url
  end

  def destroy
    @micropost.destroy
    flash[:success] = t "micro_deleted"
    redirect_to request.referer || root_url
  end

  private

  def in_create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach params[:micropost][:image]
  end

  def micropost_params
    params.require(:micropost).permit :content, :image
  end

  def find_post
    @micropost = current_user.microposts.find_by id: params[:id]
    redirect_to root_url if @micropost.nil?
  end
end
