# == Schema Information
#
# Table name: favorite_notes
#
#  id      :integer          not null, primary key
#  note_id :integer          not null
#  user_id :integer          not null
#

class FavoriteNote < ApplicationRecord
  belongs_to :note
  belongs_to :user
end
