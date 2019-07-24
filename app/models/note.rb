class Note < ApplicationRecord
  belongs_to :user, foreign_key: 'created_by_user_id'

  validates :title, presence: true
  validates :content, presence: true

  scope :my_notes, ->(user_id) { where(created_by_user_id: user_id) }

  def favorite_note?(user_id)
    User.find(user_id).favorite_notes.find_by(note_id: id).present?
  end

  def viewable_note?(user_id)
    Note.current_viewable_notes(user_id).find_by(id: id).present?
  end

  def self.current_viewable_notes(user_id)
    non_viewable_note_ids = Note.where.not(created_by_user_id: user_id).where(public_flag: false).ids
    non_viewable_note_ids.empty? ? Note.all : Note.where.not(id: non_viewable_note_ids)
  end
end
