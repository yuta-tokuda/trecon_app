# == Schema Information
#
# Table name: questionnaire_answers
#
#  id                    :bigint           not null, primary key
#  questionnaire_id      :bigint           not null
#  questionnaire_item_id :bigint           not null
#  answer_user_id        :bigint           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class QuestionnaireAnswer < ApplicationRecord
  belongs_to :answer_user, class_name: 'User', foreign_key: 'answer_user_id', inverse_of: :answer_user
  belongs_to :questionnaire
  belongs_to :item, class_name: 'QuestionnaireItem', foreign_key: 'questionnaire_item_id', inverse_of: :item

  validates :questionnaire_id, presence: true
  validates :questionnaire_item_id, presence: true
  validates :answer_user_id, presence: true
end
