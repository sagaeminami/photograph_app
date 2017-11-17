class FavoritesController < ApplicationController

  def create
    favorite = current_user.favorites.create(photo_id: params[:photo_id])
    redirect_to photos_url, notice: "#{favorite.photo.user.name}さんのブログをお気に入り登録しました"
  end

  def destroy
    favorite = current_user.favorites.find_by(photo_id: params[:photo_id]).destroy
    redirect_to photos_url, notice: "#{favorite.photo.user.name}さんのブログをお気に入り解除しました"
  end
end
