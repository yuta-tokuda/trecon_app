class CreateQuestionnaires < ActiveRecord::Migration[5.2]
  def change
    create_table :questionnaires do |t|
      t.string :title, null: false, comment: 'タイトル'
      t.integer :created_by_user_id,  comment: '作成者'

      t.timestamps
    end
  end
end
