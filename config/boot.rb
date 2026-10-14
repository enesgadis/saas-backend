# frozen_string_literal: true
# encoding: UTF-8

ENV["BUNDLE_GEMFILE"] ||= File.expand_path("Gemfile", Dir.pwd)

require "bundler/setup" if File.exist?(ENV["BUNDLE_GEMFILE"])
