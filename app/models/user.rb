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
  has_many :editors, class_name: 'UserNoteComment', foreign_key: 'editor_id', inverse_of: :editors, dependent: :destroy
  has_many :reply_users, class_name: 'UserNoteComment', foreign_key: 'reply_user_id', inverse_of: :reply_users, dependent: :destroy
  has_many :comments, dependent: :destroy, class_name: 'UserNoteComment'

  def full_name
    "#{ name_first } #{ name_last }"
  end

  def comment_reply_user?(comment)
    id == comment.reply_user_id
  end
end
