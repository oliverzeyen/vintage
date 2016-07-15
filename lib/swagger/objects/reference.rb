require 'vintage/swagger/object'

module Vintage
  module Swagger
    module Objects
      class Reference < Vintage::Swagger::Object # https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#referenceObject
        @ref = nil

        def self.parse(reference)
          return nil unless reference

          r = Vintage::Swagger::Objects::Reference.new
          r.ref = reference['$ref']
          r
        end

        def ref=(new_ref)
          raise ArgumentError.new('Vintage::Swagger::Objects::Reference#ref= $ref is nil') unless new_ref
          @ref = new_ref
        end

        attr_reader :ref

        def as_swagger
          @ref.nil? ? {} : { '$ref' => @ref }
        end
      end
    end
  end
end
