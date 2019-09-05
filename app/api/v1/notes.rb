module V1
  class Notes < Grape::API
    before { authenticate! }

    helpers do
      params :note do
        requires :uid,            type: String
        requires :Authorization,  type: String
        requires :title,          type: String
        requires :content,        type: String
        requires :public_flag,    type: Boolean
        optional :tag_list,       type: String
      end

      def note_permit_params
        ActionController::Parameters.new(params).permit(:title, :content, :public_flag, :tag_list)
      end

      def other_user_ids(user_id)
        User.where.not(id: user_id).ids
      end

      def create_note_notification(note)
        user_ids = User.other_user_ids(current_user.id)
        user_ids.each do |user_id|
          note.notifications.create(active_user_id: current_user.id, passive_user_id: user_id, kind: 'note')
        end
      end
    end

    resources :notes do
      desc 'POST /api/notes/new'
      params do
        use :note
      end

      post '/new' do
        note = Note.new(note_permit_params.merge(created_by_user_id: current_user.id))
        note.save!
        create_note_notification(note) if note.public_flag
        present message: I18n.t('api.notes.created', model_name: I18n.t('activerecord.models.note'))
      end
    end
  end
end
