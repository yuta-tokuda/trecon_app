# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name_first             :string
#  name_last              :string
#

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name_first, presence: true
  validates :name_last, presence: true

  has_many :notes, dependent: :destroy, inverse_of: :notes
  has_many :favorite_notes, dependent: :destroy
  has_many :comments, dependent: :destroy, class_name: 'UserNoteComment'
  has_many :editors, class_name: 'UserNoteComment', foreign_key: 'editor_id', inverse_of: :editors, dependent: :destroy
  has_many :reply_users, class_name: 'UserNoteComment', foreign_key: 'reply_user_id', inverse_of: :reply_users, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :active_users, class_name: 'Notification', foreign_key: 'active_user_id', inverse_of: :active_user, dependent: :destroy
  has_many :passive_users, class_name: 'Notification', foreign_key: 'passive_user_id', inverse_of: :passive_user, dependent: :destroy
  has_many :passive_notifications, -> { order(created_at: 'DESC').includes(:active_user, :note, :comment) }, class_name: 'Notification', foreign_key: 'passive_user_id', inverse_of: :passive_user

  scope :other_user_ids, ->(user_id) { where.not(id: user_id).ids }

  def full_name
    "#{ name_first } #{ name_last }"
  end

  def comment_reply_user?(comment)
    id == comment.reply_user_id
  end

  def comment_notification_present?
    passive_notifications.where(kind: 'comment').present?
  end

  def comment_notifications(note)
    passive_notifications.where(note_id: note.id, kind: 'comment')
  end

  def oldest_comment(note)
    comment_notifications(note).last.comment
  end
end
