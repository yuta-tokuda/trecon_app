class CreateQuestionnaireItems < ActiveRecord::Migration[5.2]
  def change
    create_table :questionnaire_items do |t|
      t.references :questionnaire, null: false, comment: 'アンケート'
      t.string :item, null: false, comment: '項目'

      t.timestamps
    end
  end
end
