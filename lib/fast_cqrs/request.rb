# frozen_string_literal: true

require 'dry/monads'

module FastCqrs
  # A base Request class uses deserializer to parse the Rack::Request body into
  # an easy to use hash. Useful when more data are required
  # than passed in the input
  # Usage: Inherit and override the #model method
  #
  class Request
    include Dry::Monads[:result, :try]

    def self.inherited(klass)
      super
      klass.class_eval do
        include Dry::Monads[:result, :try]
      end
    end

    def call(input)
      return fail! unless (deserialized = model(input))

      Success(deserialized)
    end

    protected

    # overwrite this to prepare valid request object
    def model(input)
      return if (deserialized = deserialize(input)).error?

      deserialized.value!
    end

    private

    attr_reader :deserializer

    def initialize(deserializer:)
      @deserializer = deserializer
    end

    def deserialize(input)
      Try { deserializer.call(input) }
    end

    def fail!
      Failure(:deserialize)
    end
  end
end
