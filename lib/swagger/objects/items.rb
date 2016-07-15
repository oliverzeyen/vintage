require 'vintage/swagger/object'

module Vintage
  module Swagger
    module Objects
      class Items < Vintage::Swagger::Object # https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#itemsObject
        swagger_attr :type, :format, :items, :collectionFormat, :default,
                     :maximum, :exclusiveMaximum, :minimum, :exclusiveMinimum,
                     :maxLength, :minLength, :pattern, :maxItems,
                     :minItems, :uniqueItems, :enum, :multipleOf

        def initialize
          @type = 'string' # we default to an array of strings
        end

        def self.parse(items)
          return nil if items.nil?

          Vintage::Swagger::Objects::Items.new.bulk_set(items)
        end

        def type=(new_type)
          raise ArgumentError.new('Vintage::Swagger::Objects::Items#type= - type is nil') unless new_type
          raise ArgumentError.new("Vintage::Swagger::Objects::Items#type= - type #{new_type} is invalid") unless %w(string number integer boolean array).include?(new_type)

          @type = new_type
        end

        def items=(new_items)
          raise ArgumentError.new('Vintage::Swagger::Objects::Items#items= - is nil') if new_items.nil? && @type == 'array'

          if !new_items.nil? && !new_items.is_a?(Vintage::Swagger::Objects::Items)
            new_items = Vintage::Swagger::Objects::Items.parse(new_items)
          end

          @items = new_items
        end

        def collectionFormat=(new_collection_format)
          return nil unless new_collection_format
          raise ArgumentError.new("Vintage::Swagger::Objects::Items#collectionFormat= - collectionFormat #{new_collection_format} is invalid") unless %w(csv ssv tsv pipes).include?(new_collection_format)
          @collectionFormat = new_collection_format
        end
      end
    end
  end
end
