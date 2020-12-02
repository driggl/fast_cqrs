# frozen_string_literal: true

require 'dry/matcher/result_matcher'
require 'dry/monads'
require 'dry/validation'

module FastCqrs
  # A base transaction class to process the request.
  # Usage: Inherit and override the #call
  #
  class Query
    Dry::Validation.load_extensions(:monads)
    def self.inherited(klass)
      super
      klass.class_eval do
        include Dry::Monads[:do, :result, :try]
        include Dry::Matcher.for(:call, with: Dry::Matcher::ResultMatcher)
      end
    end

    def call(_input, _auth: nil)
      Success()
    end
  end
end
