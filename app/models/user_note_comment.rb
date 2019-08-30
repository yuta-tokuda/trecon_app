# == Schema Information
#
# Table name: user_note_comments
#
#  id            :bigint           not null, primary key
#  editor_id     :bigint           not null
#  reply_user_id :bigint           not null
#  note_id       :bigint           not null
#  content       :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class UserNoteComment < ApplicationRecord
  has_many :notifications, dependent: :destroy, foreign_key: 'comment_id', inverse_of: :comment

  belongs_to :editor, class_name: 'User', foreign_key: 'editor_id', inverse_of: :editors
  belongs_to :reply_user, class_name: 'User', foreign_key: 'reply_user_id', inverse_of: :reply_users
  belongs_to :note

  validates :editor_id, presence: true
  validates :reply_user_id, presence: true
  validates :note_id, presence: true
  validates :content, presence: true
end
