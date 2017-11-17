class AddDetailsToPhotos < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :title, :string
    add_column :photos, :content, :text
  end
end
