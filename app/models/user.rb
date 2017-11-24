class User < ApplicationRecord
  has_many :photos
  has_many :favorites, dependent: :destroy
  has_many :favorite_photos, through: :favorites, source: :photo
  mount_uploader :image, ImageUploader
  validates :name,presence:true,length:{ maximum: 30}
  validates :email,presence:true,length:{ maximum: 255},
             format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password,presence:true,length:{ minimum: 6},  unless: :password_is_not_displayed
  before_save { email.downcase!}
  has_secure_password

  has_many :photos
  has_many :favorites, dependent: :destroy
  has_many :favorite_photos, through: :favorites, source: :photo

  def password_is_not_displayed
   # idがあれば存在しているuserなのでpassword不要で更新する
   # idなければ新規作成なのでvalidationチェックする
   !self.id.blank?
  end

end
