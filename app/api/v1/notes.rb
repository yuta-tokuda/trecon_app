module V1
  class Notes < Grape::API
    before { authenticate! }

    helpers do
      params :note do
        requires :title,          type: String
        requires :content,        type: String
        requires :public_flag,    type: Boolean
        optional :tag_list,       type: String
      end

      params :search_note do
        optional :title,              type: String
        optional :content,            type: String
        optional :tag_name,           type: String
        optional :created_by_user,    type: Integer
        optional :my_note_flag,       type: Boolean
        optional :favorite_note_flag, type: Boolean
      end

      def note_permit_params
        ActionController::Parameters.new(params).permit(:title, :content, :public_flag, :tag_list)
      end

      def other_user_ids(user_id)
        User.where.not(id: user_id).ids
      end
    end

    resources :notes do
      desc 'GET /api/v1/notes'
      params do
        use :search_note
      end

      get '/' do
        notes = Note.current_viewable_notes(current_user.id)
        notes = notes.my_notes(current_user.id) if ActiveRecord::Type::Boolean.new.cast(params[:my_note_flag])
        notes = notes.where(id: current_user.favorite_notes.map(&:note_id)) if ActiveRecord::Type::Boolean.new.cast(params[:favorite_note_flag])
        notes = notes.tagged_with(params[:tag_name].to_s) if params[:tag_name].present?
        notes = notes.where(['title LIKE ?', "%#{ params[:title] }%"]) if params[:title].present?
        notes = notes.where(['content LIKE ?', "%#{ params[:content] }%"]) if params[:content].present?

        present notes, with: Entities::NoteEntity::NoteSearchEntity, current_user: current_user
      end

      desc 'POST /api/v1/notes/new'
      params do
        use :note
      end

      post '/new' do
        note = Note.new(note_permit_params.merge(created_by_user_id: current_user.id))
        note.save!
        present note: note
      end

      route_param :id, type: Integer do
        desc 'GET /api/v1/notes/:id'

        get '/' do
          note = Note.find(params[:id])
          present note, with: Entities::NoteEntity
        end

        desc 'PATCH /api/v1/notes/:id'
        params do
          use :note
        end

        patch '/' do
          note = current_user.notes.find(params[:id])
          if note.created_by_user_id == current_user.id
            note.update!(note_permit_params)
            present note: note
          else
            error!(I18n.t('api.notes.unauthorized'), 403)
          end
        end

        desc 'DELETE /api/v1/notes/:id'
        delete '/' do
          note = current_user.notes.find(params[:id])
          if note.created_by_user_id == current_user.id
            note.destroy!
            present message: I18n.t('api.notes.deleted')
          else
            error!(I18n.t('api.notes.unauthorized'), 403)
          end
        end
      end
    end
  end
end
