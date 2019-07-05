module ApplicationHelper
  require 'redcarpet'
  require 'coderay'

  class HTMLwithCoderay < Redcarpet::Render::HTML
  end

  def markdown(text)
    html_render = HTMLwithCoderay.new(filter_html: true, hard_wrap: true)
    options = {
      autolink: true,
      space_after_headers: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      tables: true,
      hard_wrap: true,
      xhtml: true,
      lax_html_blocks: true,
      strikethrough: true
    }
    markdown = Redcarpet::Markdown.new(html_render, options)
    markdown.render(text)
  end

  # ページングセレクト
  def per_pages_for_select
    [%w[50 50], %w[100 100], %w[150 150], %w[200 200]]
  end
end
