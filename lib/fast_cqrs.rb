# frozen_string_literal: true

require 'fast_cqrs/version'
require 'fast_cqrs/authorizer'
require 'fast_cqrs/request'
require 'fast_cqrs/transaction'
require 'fast_cqrs/query'

module FastCqrs
  class Error < StandardError; end
end
