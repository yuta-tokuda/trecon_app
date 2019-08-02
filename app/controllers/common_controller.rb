class CommonController < ApplicationController
  def preview
    @content = params[:content]
  end
end
