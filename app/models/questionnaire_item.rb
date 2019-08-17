# == Schema Information
#
# Table name: questionnaire_items
#
#  id               :bigint           not null, primary key
#  questionnaire_id :bigint           not null
#  item             :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class QuestionnaireItem < ApplicationRecord
  belongs_to :questionnaire

  validates :item, presence: true
end
