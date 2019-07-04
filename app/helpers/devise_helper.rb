module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    html = ''

    # エラーメッセージ用のHTMLを生成
    resource.errors.full_messages.each_with_index do |msg, i|
      add_class = i.to_i.zero? ? 'mt10' : ''
      html += <<-SQL
        <div class="error_field alert alert-danger #{ add_class }" role="alert">
          <span class="error_msg">#{ msg }</span>
        </div>
      SQL
    end

    html.html_safe
  end

  def devise_error_messages?
    resource.errors.empty? ? false : true
  end
end
