# frozen_string_literal: true
# encoding: UTF-8

require File.expand_path("config/boot", Dir.pwd)

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"

Bundler.require(*Rails.groups)

module OmniResolve
  class Application < Rails::Application
    config.load_defaults 8.0
    config.api_only = true
  end
end
