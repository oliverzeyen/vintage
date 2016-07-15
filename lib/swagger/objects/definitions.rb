require 'vintage/swagger/object'
require 'vintage/swagger/objects/schema'

module Vintage
  module Swagger
    module Objects
      class Definitions < Vintage::Swagger::Object # https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#definitionsObject
        def initialize
          @definitions = {}
        end

        def self.parse(definitions)
          return nil unless definitions

          definition = Vintage::Swagger::Objects::Definitions.new

          definitions.each do |definition_name, definition_value|
            definition.add_definition(definition_name, definition_value)
          end

          definition
        end

        def add_definition(definition_name, definition_value)
          raise ArgumentError.new('Vintage::Swagger::Objects::Definitions#add_definition - definition_name is nil') unless definition_name
          raise ArgumentError.new('Vintage::Swagger::Objects::Definitions#add_definition - definition_value is nil') unless definition_value

          unless definition_value.is_a?(Vintage::Swagger::Objects::chema)
            definition_value = Vintage::Swagger::Objects::chema.parse(definition_value)
          end

          @definitions[definition_name] = definition_value
        end

        def [](key)
          @definitions[key]
        end

        def as_swagger
          swagger_defs = {}

          @definitions.each do |def_k, def_v|
            swagger_defs[def_k] = def_v.to_swagger
          end

          swagger_defs
        end
      end
    end
  end
end
