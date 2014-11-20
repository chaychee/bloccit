class AddEmailFavoritesToUser < ActiveRecord::Migration
  def change
    add_column :users, :email_favorites, :boolean, default: false
  end
end
