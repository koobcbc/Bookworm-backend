class ChangeColumnTypeBooks < ActiveRecord::Migration[6.0]
  def change
    change_column :books, :image_url, :text
  end
end
