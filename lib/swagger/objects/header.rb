require 'vintage/swagger/object'
require 'vintage/swagger/objects/items'

module Vintage
  module Swagger
    module Objects
      class Header < Vintage::Swagger::Object # https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#header-object
        swagger_attr :description, :type, :format, :items,
                     :collectionFormat, :default, :maximum,
                     :exclusiveMaximum, :minimum, :exclusiveMinimum,
                     :maxLength, :minLength, :pattern, :maxItems,
                     :minItems, :uniqueItems, :enum, :multipleOf

        def self.parse(header)
          return nil unless header

          Vintage::Swagger::Objects::Header.new.bulk_set(header)
        end

        def type=(new_type)
          raise ArgumentError.new('Vintage::Swagger::Objects::Header#type called with nil') if new_type.nil?
          @type = new_type
        end

        def items=(new_items)
          raise ArgumentError.new('Vintage::Swagger::Objects::Header#items= items is nil') if new_items.nil? && @type == 'array'
          if !new_items.nil? && !new_items.is_a?(Vintage::Swagger::Objects::Items)
            new_items = Vintage::Swagger::Objects::Items.parse(new_items)
          end

          @items = new_items
        end
      end
    end
  end
end
