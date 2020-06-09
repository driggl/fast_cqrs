# frozen_string_literal: true

require 'dry/matcher/result_matcher'
require 'dry/monads'
require 'dry/validation'

module FastCqrs
  class Transaction
    Dry::Validation.load_extensions(:monads)
    def self.inherited(klass)
      super
      klass.class_eval do
        include Dry::Monads[:do, :result, :try]
        include Dry::Matcher.for(:call, with: Dry::Matcher::ResultMatcher)
      end
    end

    def call(input, **)
      Success()
    end
  end
end
