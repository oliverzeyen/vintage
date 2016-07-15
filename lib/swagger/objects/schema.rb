require 'vintage/swagger/object'
require 'vintage/swagger/objects/reference'
require 'vintage/swagger/objects/xml_object'
require 'vintage/swagger/objects/external_documentation'

module Vintage
  module Swagger
    module Objects
      class Schema < Vintage::Swagger::Object # https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#schemaObject
        swagger_attr :discriminator, :readOnly, :xml, :externalDocs, :example,
                     :format, :title, :description, :default,
                     :multipleOf, :maximum, :exclusiveMaximum, :minimum,
                     :exclusiveMinimum, :maxLength, :minLength,
                     :pattern, :maxItems, :minItems, :uniqueItems, :maxProperties,
                     :minProperties, :required, :enum, :type, :items, :allOf,
                     :properties, :additionalProperties

        attr_reader :ref

        def self.parse(schema)
          return nil if schema.nil?

          sc = Vintage::Swagger::Objects::chema.new.bulk_set(schema)
          sc.ref = schema['$ref']
          sc
        end

        def ref=(new_ref)
          return nil unless new_ref

          @ref = new_ref
        end

        def externalDocs=(new_doc)
          return nil unless new_doc

          unless new_doc.is_a?(Vintage::Swagger::Objects::ExternalDocumentation)
            new_doc = Vintage::Swagger::Objects::ExternalDocumentation.parse(new_doc)
          end

          @externalDocs = new_doc
        end

        def xml=(new_xml)
          return nil unless new_xml

          unless new_xml.is_a?(Vintage::Swagger::Objects::XMLObject)
            new_xml = Vintage::Swagger::Objects::XMLObject.parse(new_xml)
          end

          @xml = new_xml
        end

        def []=(attrib, value)
          send("#{attrib}=", value)
        end

        def [](attrib)
          send(attrib.to_s)
        end

        def as_swagger
          res = super
          res['$ref'] = @ref if @ref
          res
        end
      end
    end
  end
end
