module V1
  class Notes < Grape::API
    include Concerns::Authenticatable
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
      desc 'POST /api/notes/new'
      params do
        use :authentication
        use :note
      end

      post '/new' do
        note = Note.new(note_permit_params.merge(created_by_user_id: current_user.id))
        note.save!
        present note: note
      end
    end
  end
end
