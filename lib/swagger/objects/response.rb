require 'vintage/swagger/object'
require 'vintage/swagger/objects/schema'
require 'vintage/swagger/objects/headers'
require 'vintage/swagger/objects/example'

module Vintage
  module Swagger
    module Objects
      class Response < Vintage::Swagger::Object # https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#responseObject
        swagger_attr :description, :schema, :headers, :examples

        def self.parse(response)
          return nil unless response

          r = Vintage::Swagger::Objects::Response.new

          r.description = response['description']
          r.schema = Vintage::Swagger::Objects::chema.parse(response['schema'])
          r.headers = Vintage::Swagger::Objects::Headers.parse(response['headers'])
          r.examples = Vintage::Swagger::Objects::Example.parse(response['examples'])

          r
        end
      end
    end
  end
end
