module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    html = ''
    resource.errors.full_messages.each do |errmsg|
      html += <<-EOF
      <div class="error_alert alert-danger flash-span" role="alert">
        <button type="button" class="close" data-dismiss="alert">
          <span aria-hidden="true">&times;</span>
          <span class="sr-only">close</span>
        </button>
        #{ errmsg }
      </div>
      EOF
    end
    html.html_safe
  end

  def devise_error_messages?
    resource.errors.empty? ? false : true
  end
end
