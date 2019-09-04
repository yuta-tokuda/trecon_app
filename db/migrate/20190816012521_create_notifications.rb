class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :active_user,  null: false, comment: '通知を送るユーザー'
      t.references :passive_user,              comment: '通知を受けるユーザー'
      t.references :note,                      comment: 'ノートID'
      t.references :comment,                   comment: 'コメントID'
      t.string :kind,             null: false, comment: 'noteもしくはcomment'

      t.timestamps
    end
  end
end
