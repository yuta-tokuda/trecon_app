class CreateFavoriteNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :favorite_notes do |t|
      t.references :note, null: false, comment: 'ノートID'
      t.references :user, null: false, comment: 'ユーザーID'
    end
  end
end
