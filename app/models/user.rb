class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name_first, presence: true
  validates :name_last, presence: true

  def full_name
    "#{ name_first } #{ name_last }"
  end

  def name_present?
    name_first.present? && name_last.present?
  end
end
