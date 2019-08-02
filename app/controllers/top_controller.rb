class TopController < ApplicationController
  def index
    return unless user_signed_in?

    notes = viewable_notes.includes(:user, :comments)
                          .group_by { |n| n.updated_at.to_date }

    note_comments = viewable_notes.includes(comments: [:reply_user])
                                  .map(&:comments)
                                  .flatten
                                  .group_by { |nc| nc.updated_at.to_date }

    @update_info = notes.merge(note_comments)
                        .sort
                        .reverse
  end

  private

  def viewable_notes
    @_viewable_notes ||= Note.current_viewable_notes(current_user.id)
  end
end
