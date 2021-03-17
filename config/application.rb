require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module KintoreNote
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    
    #アプリケーションタイムゾーンを東京に設定
    config.time_zone = 'Tokyo'
    
    #日本語化対応(config/locales/ja.ymlを参照)
    config.i18n.default_locale = :ja
    
    # バリデーションエラー時のfield_with_errorsの自動挿入を阻止
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag }
  end
end
