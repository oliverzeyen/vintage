require 'vintage/swagger/object'
require 'vintage/swagger/objects/reference'
require 'vintage/swagger/objects/response'

module Vintage
  module Swagger
    module Objects
      class Responses < Vintage::Swagger::Object # https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#responsesObject
        def initialize
          @responses = {}
        end

        def self.parse(responses)
          return nil unless responses

          r = Vintage::Swagger::Objects::Responses.new

          responses.each do |response_key, response_value|
            r.add_response(response_key, response_value)
          end

          r
        end

        def add_response(response_code, response)
          raise ArgumentError.new('Vintage::Swagger::Objects::Responses#add_response - response is nil') unless response

          if !response.is_a?(Vintage::Swagger::Objects::Reference) && !response.is_a?(Vintage::Swagger::Objects::Response)
            # it's a reference object or it's a parameter object
            response = response['$ref'] ? Vintage::Swagger::Objects::Reference.parse(response) : Vintage::Swagger::Objects::Response.parse(response)
          end

          @responses[response_code] = response
        end

        def [](key)
          @responses[key]
        end

        def as_swagger
          res = {}

          @responses.each do |other_name, other_value|
            res[other_name] = other_value.to_swagger
          end

          res
        end
      end
    end
  end
end
