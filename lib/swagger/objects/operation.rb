require 'vintage/swagger/object'
require 'vintage/swagger/objects/external_documentation'
require 'vintage/swagger/objects/responses'
require 'vintage/swagger/objects/security_requirement'

module Vintage
  module Swagger
    module Objects
      class Operation < Vintage::Swagger::Object # https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#operationObject
        swagger_attr :tags, :summary, :description, :externalDocs, :operationId,
                     :consumes, :produces, :parameters, :responses,
                     :schemes, :deprecated, :security

        def self.parse(operation)
          return unless operation

          Vintage::Swagger::Objects::Operation.new.bulk_set(operation)
        end

        def externalDocs=(newDoc)
          return nil unless newDoc

          unless newDoc.is_a?(Vintage::Swagger::Objects::ExternalDocumentation)
            newDoc = Vintage::Swagger::Objects::ExternalDocumentation.parse(newDoc)
          end

          @externalDocs = newDoc
        end

        def responses=(newResp)
          return nil unless newResp

          unless newResp.is_a?(Vintage::Swagger::Objects::Responses)
            newResp = Vintage::Swagger::Objects::Responses.parse(newResp)
          end

          @responses = newResp
        end

        def security=(newSecurity)
          return nil unless newSecurity

          @security = []

          newSecurity.each do |sec_object|
            unless sec_object.is_a?(Vintage::Swagger::Objects::ecurityRequirement)
              sec_object = Vintage::Swagger::Objects::ecurityRequirement.parse(sec_object)
            end

            @security.push(sec_object)
          end
        end

        def parameters=(newParams)
          return nil unless newParams

          @parameters = []

          newParams.each do |parameter|
            add_parameter(parameter)
          end
        end

        def add_parameter(new_parameter)
          @parameters ||= []

          if new_parameter.is_a?(Hash)

            new_parameter = if new_parameter['$ref']
                              # it's a reference object
                              Vintage::Swagger::Objects::Reference.parse(new_parameter)
                            else
                              # it's a parameter object
                              Vintage::Swagger::Objects::Parameter.parse(new_parameter)
                            end

          end

          @parameters.push(new_parameter)
        end
      end
    end
  end
end
