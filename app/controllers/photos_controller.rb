class PhotosController < ApplicationController
  before_action :set_photo, only: [:show,:edit,:update,:destroy]
  before_action :logged_in_user, only: [:new,:edit,:show]

  def index
    @photos = Photo.all
  end

  def new
    @photo = Photo.new
  end

  def show
    @favorite = current_user.favorites.find_by(photo_id: @photo.id)
  end

  def edit
  end

  def confirm
    @photo = Photo.new(photo_params)
  end


  def update
    if @photo.update(photo_params)
      redirect_to photos_path, notice:"ツイートを編集しました"
    else
      render 'edit'
    end
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.user_id = current_user.id
    @photo.image.retrieve_from_cache!(params[:cache][:image]) unless (params[:cache][:image]).empty?
      if @photo.save
        PhotoMailer.photo_mail(@photo).deliver  ##追記
        redirect_to photos_path, notice:"ツイートしました！"
      else
        render 'new'
      end
  end

  def destroy
    @photo.destroy
    redirect_to photos_path, notice:"ツイートを削除しました"
  end

  def favorite
    @favorite_photos = current_user.favorite_photos
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "ログインしてください"
      redirect_to new_session_path
    end
  end


  private
  def photo_params
    params.require(:photo).permit(:title,:content,:image)
  end
end
