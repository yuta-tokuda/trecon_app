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

  # ユーザー名/ユーザーidの配列
  def select_for_users
    User.all
        .order(:name_first)
        .map { |user| [user.full_name, user.id] }
  end

  # 今日との差分
  def date_diff_str(datetime)
    today = Time.zone.today
    current_date = datetime.to_date

    if current_date == today
      # 現時刻の差分
      time_diff = (Time.zone.now - datetime).round / (60 * 60)
      min_diff = (Time.zone.now - datetime).round / 60

      time_diff.to_i.zero? ? "#{ min_diff }分前" : "#{ time_diff }時間前"
    else
      # 日付の差分
      "#{ (current_date - today).to_i.abs }日前"
    end
  end
end
