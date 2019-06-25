require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SkipTest
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.autoload_paths += %W(#{ config.root }/lib)

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Tokyo'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ja

    config.paths['config/routes.rb'].concat Dir[Rails.root.join('config/routes/*.rb')]
    config.assets.initialize_on_precompile = false

    # errorをdivでなくspanで括ることで改行されない
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| %(<span class="field_with_errors">#{ html_tag }</span>).html_safe }

    config.autoload_paths += %W(#{ config.root }/lib)
    config.autoload_paths += Dir["#{ Rails.root }/lib/*.rb"].each {|file| require file }
    config.paths.add 'lib', eager_load: true
  end
end
