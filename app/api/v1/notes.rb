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

      def note_permit_params
        ActionController::Parameters.new(params).permit(:title, :content, :public_flag, :tag_list)
      end

      def other_user_ids(user_id)
        User.where.not(id: user_id).ids
      end
    end

    resources :notes do
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
          present note: note
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
