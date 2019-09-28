class CommonController < ApplicationController
  def preview
    @content = params[:content]
  end

  def realtime_preview
    @content = params[:content]
  end
end
