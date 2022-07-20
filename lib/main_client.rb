# frozen_string_literal: true

require_relative "main_client/version"
require 'request_store'
require 'main_client/engine'

module MainClient
  class AuthRequired < StandardError; end
end
