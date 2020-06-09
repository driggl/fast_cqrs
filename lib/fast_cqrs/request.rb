# frozen_string_literal: true

require 'dry/monads'

module FastCqrs
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
