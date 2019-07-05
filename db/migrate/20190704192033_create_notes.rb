class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.string :title,  null: false,  comment: 'タイトル'
      t.string :content, null: false, comment: '内容'
      t.integer :created_by_user_id,  comment: '登録者'
      t.timestamps
    end
  end
end

