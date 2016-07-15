require 'vintage/swagger/object'

module Vintage
  module Swagger
    module Objects
      class XMLObject < Vintage::Swagger::Object # https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#xmlObject
        swagger_attr :name, :namespace, :prefix, :attribute, :wrapped

        def self.parse(xml_object)
          return nil unless xml_object

          Vintage::Swagger::Objects::XMLObject.new.bulk_set(xml_object)
        end
      end
    end
  end
end
