class AddPublicFlagToNotes < ActiveRecord::Migration[5.0]
  def change
    add_column :notes, :public_flag, :boolean, null: false, default: true, comment: '公開フラグ'
  end
end
