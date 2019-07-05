class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name_first, presence: true
  validates :name_last, presence: true

  has_many :notes, dependent: :destroy
  has_many :favorite_notes, dependent: :destroy

  def full_name
    "#{ name_first } #{ name_last }"
  end
end
