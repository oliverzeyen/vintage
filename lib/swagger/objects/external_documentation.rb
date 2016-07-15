require 'vintage/swagger/object'

module Vintage
  module Swagger
    module Objects
      class ExternalDocumentation < Vintage::Swagger::Object # https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#externalDocumentationObject
        swagger_attr :url, :description

        def initialize
          @url = 'http://localhost'
        end

        def self.parse(external)
          return nil unless external

          Vintage::Swagger::Objects::ExternalDocumentation.new.bulk_set(external)
        end

        def url=(new_url)
          raise ArgumentError.new('Vintage::Swagger::Objects::ExternalDocumentation#url - url is nil') unless new_url
          @url = new_url
        end
      end
    end
  end
end
