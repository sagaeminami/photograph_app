class PhotoMailer < ApplicationMailer
  def photo_mail(photo)
    @photo = photo
    mail to: @photo.user.email,
        subject: "お問い合わせの確認メール"
  end
end
