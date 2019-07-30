class CreateUserNoteComments < ActiveRecord::Migration[5.2]
  def change
    create_table :user_note_comments do |t|
      t.references :editor,        null: false, comment: 'noteを投稿したユーザーID'
      t.references :reply_user,    null: false, comment: 'コメントしたユーザーID'
      t.references :note,          null: false, comment: 'ノートID'
      t.string :content,           null: false, comment: 'ノートに対してのコメント内容'

      t.timestamps
    end
  end
end
