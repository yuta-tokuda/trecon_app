# == Schema Information
#
# Table name: questionnaires
#
#  id                 :bigint           not null, primary key
#  title              :string           not null
#  created_by_user_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Questionnaire < ApplicationRecord
  belongs_to :created_user, class_name: 'User', foreign_key: 'created_by_user_id', inverse_of: :questionnaires

  has_many :items, class_name: 'QuestionnaireItem', dependent: :destroy

  accepts_nested_attributes_for :items, allow_destroy: true

  validates :created_by_user_id, presence: true
  validates :title, presence: true

  scope :my_questionnaires, ->(user_id) { where(created_by_user_id: user_id) }
end
