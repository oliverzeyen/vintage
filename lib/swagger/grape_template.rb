require 'swagger/base'
require 'swagger/routes'
require 'swagger/type'
require 'swagger/objects/document'
require 'swagger/objects/security_scheme'
require 'swagger/objects/security_definitions'
require 'swagger/objects/definitions'

module Vintage
  module Grape
    class Template
      def self.generate(base_class)
        swagger_doc = Vintage::Template.generate

        routes = Vintage::Grape::Routes.new(base_class.routes)


        swagger_doc.paths = routes.to_swagger
        swagger_doc.definitions = Vintage::Data::Definitions.new

        extract_all_types(routes.types).sort { |a, b| a.to_s <=> b.to_s }.each do |type|
          grape_type = Vintage::Grape::Type.new(type)

          # Skip runtime defintions
          next if type.to_s.include?('Class')

          swagger_doc.definitions.add_definition(type.to_s, grape_type.to_swagger(false))
        end

        if routes.scopes.present?
          scheme = Vintage::Data::SecurityScheme.new
          scheme.type = 'oauth2'
          scheme.flow = 'accessCode'
          scheme.authorizationUrl = 'https://'
          scheme.tokenUrl = 'https://'
          scopes = {}
          routes.scopes.uniq.each do |scope|
            scopes[scope] = ''
          end
          scheme.scopes = scopes

          swagger_doc.securityDefinitions = Vintage::Data::SecurityDefinitions.new
          swagger_doc.securityDefinitions.add_param('oauth2', scheme)
        end

        swagger_doc
      end

      def self.extract_all_types(types, all_types = [])
        return all_types.uniq if types.empty?

        new_types = []

        types.each do |type|
          all_types << type unless all_types.map(&:to_s).include?(type.to_s)

          grape_type = Vintage::Grape::Type.new(type)

          grape_type.sub_types.each do |new_type|
            unless all_types.map(&:to_s).include?(new_type.to_s)
              new_types << new_type
              all_types << new_type
            end
          end
        end

        extract_all_types(new_types, all_types)
      end
    end
  end
end
