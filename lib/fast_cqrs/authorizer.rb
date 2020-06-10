# frozen_string_literal: true

require 'dry/monads'

module FastCqrs
  # A base Authorizer class used to validate the access to the given resource
  # an easy to use hash.
  # Usage: Inherit and override the #authorize method
  #
  class Authorizer
    def self.inherited(klass)
      super
      klass.class_eval do
        include Dry::Monads[:result, :do]
      end
    end

    def call(**)
      return Success() if authorize

      fail!
    end

    protected

    # Override this in the inherited class
    def authorize
      true
    end

    private

    def fail!
      Failure(:authorize)
    end
  end
end
