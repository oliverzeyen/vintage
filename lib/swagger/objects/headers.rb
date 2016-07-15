require 'vintage/swagger/object'
require 'vintage/swagger/objects/header'

module Vintage
  module Swagger
    module Objects
      class Headers < Vintage::Swagger::Object # https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#headersObject
        def initialize
          @headers = {}
        end

        def self.parse(headers)
          return nil unless headers

          h = Vintage::Swagger::Objects::Headers.new

          headers.each { |header_key, header_value| h.add_header(header_key, header_value) }

          h
        end

        def add_header(header_key, header_value)
          raise ArgumentError.new('Vintage::Swagger::Objects::Headers#add_header - parameter name is nil') unless header_key
          raise ArgumentError.new('Vintage::Swagger::Objects::Headers#add_header - parameter value is nil') unless header_value

          unless header_value.is_a?(Vintage::Swagger::Objects::Header)
            header_value = Vintage::Swagger::Objects::Header.parse(header_value)
          end

          @headers[header_key] = header_value
        end

        def [](key)
          @headers[key]
        end

        def as_swagger
          res = {}

          @headers.each do |key, value|
            res[key] = value.to_swagger
          end

          res
        end
      end
    end
  end
end
