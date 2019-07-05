module ApplicationHelper
  require 'redcarpet'
  require 'coderay'

  class HTMLwithCoderay < Redcarpet::Render::HTML
  end

  def markdown(text)
    options = {
        hard_wrap: true,
        no_intra_emphasis: true
    }

    extensions = {
        autolink: true,
        fenced_code_blocks: true,
        lax_spacing: true,
        no_intra_emphasis: true,
        strikethrough: true,
        superscript: true,
        tables: true
    }
    renderer = Redcarpet::Render::HTML.new(options)
    @markdown = Redcarpet::Markdown.new(renderer, extensions)
    @markdown.render(text).html_safe
  end

  # ページングセレクト
  def per_pages_for_select
    [%w[50 50], %w[100 100], %w[150 150], %w[200 200]]
  end
end
