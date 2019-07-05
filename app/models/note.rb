class Note < ApplicationRecord
  belongs_to :user, foreign_key: 'created_by_user_id'

  validates :title, presence: true
  validates :content, presence: true

  def favorite_note?(user_id)
    User.find(user_id).favorite_notes.find_by(note_id: id).present?
  end
end
