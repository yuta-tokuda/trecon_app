class CreateQuestionnaireAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :questionnaire_answers do |t|
      t.references :questionnaire, null: false, comment: 'アンケート'
      t.references :questionnaire_item, null: false, comment: 'アンケート項目'
      t.references :answer_user, null: false, comment: '回答者'

      t.timestamps
    end
  end
end
