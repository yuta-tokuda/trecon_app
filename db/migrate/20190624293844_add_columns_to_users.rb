class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name_first,      :string, comment: '姓'
    add_column :users, :name_last,       :string, comment: '名'
  end
end
