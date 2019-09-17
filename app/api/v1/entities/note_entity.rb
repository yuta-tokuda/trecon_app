module V1
  module Entities
    class NoteEntity < Grape::Entity
      expose :id
      expose :favorite do |note, options|
        note.favorite_note?(options[:current_user].id)
      end
      expose :title
      expose :content
      expose :created_by_user do |note|
        note.created_by_user.full_name
      end
      expose :created_at do |note|
        note.created_at.strftime('%Y/%m/%d %H:%M')
      end
      expose :updated_at do |note|
        note.updated_at.strftime('%Y/%m/%d %H:%M')
      end
      expose :public_flag
      expose :tag_list
    end
  end
end
