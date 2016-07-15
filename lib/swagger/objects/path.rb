require 'vintage/swagger/object'
require 'vintage/swagger/objects/operation'
require 'vintage/swagger/objects/parameter'
require 'vintage/swagger/objects/reference'

module Vintage
  module Swagger
    module Objects
      class Path < Vintage::Swagger::Object # https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#path-item-object
        swagger_attr :get, :put, :post, :delete, :options, :head, :patch, :parameters # and $ref
        @ref = nil

        def self.parse(path)
          raise ArgumentError.new('Vintage::Swagger::Objects::Path - path is nil') unless path

          res = Vintage::Swagger::Objects::Path.new.bulk_set(path)
          res.ref = path['$ref'] if path['$ref']
          res
        end

        def all_methods
          [@get, @put, @post, @delete, @options, @head, @patch].compact
        end

        def get=(new_get)
          return nil unless new_get
          unless new_get.is_a?(Vintage::Swagger::Objects::Operation)
            new_get = Vintage::Swagger::Objects::Operation.parse(new_get)
          end

          @get = new_get
        end

        def put=(new_put)
          return nil unless new_put
          unless new_put.is_a?(Vintage::Swagger::Objects::Operation)
            new_put = Vintage::Swagger::Objects::Operation.parse(new_put)
          end
          @put = new_put
        end

        def post=(new_post)
          return nil unless new_post
          unless new_post.is_a?(Vintage::Swagger::Objects::Operation)
            new_post = Vintage::Swagger::Objects::Operation.parse(new_post)
          end
          @post = new_post
        end

        def delete=(new_delete)
          return nil unless new_delete
          unless new_delete.is_a?(Vintage::Swagger::Objects::Operation)
            new_delete = Vintage::Swagger::Objects::Operation.parse(new_delete)
          end
          @delete = new_delete
        end

        def options=(new_options)
          return nil unless new_options
          unless new_options.is_a?(Vintage::Swagger::Objects::Operation)
            new_options = Vintage::Swagger::Objects::Operation.parse(new_options)
          end
          @options = new_options
        end

        def head=(new_head)
          return nil unless new_head
          unless new_head.is_a?(Vintage::Swagger::Objects::Operation)
            new_head = Vintage::Swagger::Objects::Operation.parse(new_head)
          end

          @head = new_head
        end

        def patch=(new_patch)
          return nil unless new_patch
          unless new_patch.is_a?(Vintage::Swagger::Objects::Operation)
            new_patch = Vintage::Swagger::Objects::Operation.parse(new_patch)
          end
          @patch = new_patch
        end

        def parameters=(new_parameters)
          return nil unless new_parameters
          raise ArgumentError.new('Vintage::Swagger::Objects::Path#parameters= - parameters is not an array') unless new_parameters.is_a?(Array)

          @parameters = []

          new_parameters.each do |parameter|
            new_param = if parameter['$ref']
                          # it's a reference object
                          Vintage::Swagger::Objects::Reference.parse(parameter)
                        else
                          # it's a parameter object
                          Vintage::Swagger::Objects::Parameter.parse(parameter)
                        end

            @parameters.push(new_param)
          end
        end

        def ref=(new_ref)
          return nil unless new_ref
          raise ArgumentError.new('Vintage::Swagger::Objects::Path#ref= - $ref is not a string') unless new_ref.is_a?(String)

          @ref = new_ref
        end

        attr_reader :ref

        def as_swagger
          res = super
          res['$ref'] = @ref if @ref
          res
        end
      end
    end^
  end
end
