# frozen_string_literal: true

require 'ostruct'

module FastCqrs
  module Deserializer
    # Transforms the JSON API request body to a flat hash
    # Input: { data: { id: 1, type: 'foo', attributes: { bar: 'bar' } } }
    # Output: { id: 1, resource_type: 'foo', bar: 'bar' }
    #
    class JsonApi
      IncorrectFormat = Class.new(StandardError)
      HashInputRequired = Class.new(StandardError)

      # Converts the json_api (https://jsonapi.org) hash resource into a flat hash
      # (defaults to `{ data: {} }`)
      #
      # == Parameters:
      # params::
      #   A request body in form of JSON API hash with symbolized keys.
      #
      # == Returns:
      # A hash with ID and all attributes flat
      #
      def call(params = { data: {} })
        raise HashInputRequired unless params.is_a?(Hash)
        raise IncorrectFormat if (data = params[:data]).blank?

        attrs = data[:attributes] || {}

        attrs.merge(id: data[:id], resource_type: data[:type])
      end
    end
  end
end
