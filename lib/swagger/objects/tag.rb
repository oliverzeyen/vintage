require 'vintage/swagger/object'
require 'vintage/swagger/objects/external_documentation'

module Vintage
  module Swagger
    module Objects
      class Tag < Vintage::Swagger::Object # https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#tag-object
        swagger_attr :name, :description, :externalDocs

        def self.parse(xml_object)
          return nil unless xml_object

          Vintage::Swagger::Objects::Tag.new.bulk_set(xml_object)
        end

        def externalDocs=(newDoc)
          return nil unless newDoc

          newDoc = Vintage::Swagger::Objects::ExternalDocumentation.parse(newDoc) unless newDoc.is_a?(Vintage::Swagger::Objects::ExternalDocumentation)

          @externalDocs = newDoc
        end
      end
    end
  end
end
