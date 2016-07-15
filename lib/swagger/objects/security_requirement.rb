require 'vintage/swagger/object'

module Vintage
  module Swagger
    module Objects
      class SecurityRequirement < Vintage::Swagger::Object # https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#securityRequirementObject
        def initialize
          @requirements = {}
        end

        def self.parse(security)
          return nil unless security

          s = Vintage::Swagger::Objects::ecurityRequirement.new
          security.each { |key, reqs| s.add_requirement(key, reqs) }
          s
        end

        def add_requirement(key, requirements)
          raise ArgumentError.new('Vintage::Swagger::Objects::ecurityRequirement#add_requirement - key is nil') unless key
          raise ArgumentError.new('Vintage::Swagger::Objects::ecurityRequirement#add_requirement - requirements is nil') unless requirements
          raise ArgumentError.new('Vintage::Swagger::Objects::ecurityRequirement#add_requirement - requirements is not an array') unless requirements.is_a?(Array)

          @requirements[key] = requirements
        end

        def [](key)
          @requirements[key]
        end

        def as_swagger
          @requirements
        end
      end
    end
  end
end
