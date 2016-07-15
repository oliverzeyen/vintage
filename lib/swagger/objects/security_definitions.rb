require 'vintage/swagger/object'
require 'vintage/swagger/objects/security_scheme'

module Vintage
  module Swagger
    module Objects
      class SecurityDefinitions < Vintage::Swagger::Object # https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#securityDefinitionsObject
        def initialize
          @security = {}
        end

        def self.parse(security)
          return nil unless security

          params = Vintage::Swagger::Objects::ecurityDefinitions.new

          security.each do |pname, pvalue|
            params.add_param(pname, pvalue)
          end

          params
        end

        def add_param(pname, pvalue)
          raise ArgumentError.new('Vintage::Swagger::Objects::ecurityDefinitions#add_param - parameter name is nil') unless pname
          raise ArgumentError.new('Vintage::Swagger::Objects::ecurityDefinitions#add_param - parameter value is nil') unless pvalue

          unless pvalue.is_a?(Vintage::Swagger::Objects::ecurityScheme)
            pvalue = Vintage::Swagger::Objects::ecurityScheme.parse(pvalue)
          end

          @security[pname] = pvalue
        end

        def [](pname)
          @security[pname]
        end

        def as_swagger
          swagger_params = {}

          @security.each do |p_k, p_v|
            swagger_params[p_k] = p_v.to_swagger
          end

          swagger_params
        end
      end
    end
  end
end
