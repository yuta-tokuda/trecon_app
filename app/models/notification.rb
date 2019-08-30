# == Schema Information
#
# Table name: notifications
#
#  id              :bigint           not null, primary key
#  active_user_id  :bigint           not null
#  passive_user_id :bigint
#  note_id         :bigint
#  comment_id      :bigint
#  kind            :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Notification < ApplicationRecord
  validates :active_user_id, presence: true
  validates :passive_user_id, presence: true
  validates :kind, presence: true

  belongs_to :active_user, class_name: 'User', foreign_key: 'active_user_id', inverse_of: :active_users
  belongs_to :passive_user, class_name: 'User', foreign_key: 'passive_user_id', inverse_of: :passive_users
  belongs_to :note, inverse_of: :notifications
  belongs_to :comment, class_name: 'UserNoteComment', foreign_key: 'comment_id', inverse_of: :notifications
end
