# == Schema Information
#
# Table name: notes
#
#  id                 :integer          not null, primary key
#  title              :string           not null
#  content            :string           not null
#  created_by_user_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  public_flag        :boolean          default(TRUE), not null
#

class Note < ApplicationRecord
  belongs_to :user, foreign_key: 'created_by_user_id', inverse_of: :notes

  has_many :comments, dependent: :destroy, class_name: 'UserNoteComment'
  has_many :notifications, dependent: :destroy

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

  def created_user?(user_id)
    created_by_user_id == user_id
  end

  def public_flag_change?
    public_flag_previous_change[0] == false && public_flag_previous_change[1] == true
  end
end
