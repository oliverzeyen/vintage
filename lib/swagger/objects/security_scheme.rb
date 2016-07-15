require 'vintage/swagger/object'
require 'vintage/swagger/objects/scopes'

module Vintage
  module Swagger
    module Objects
      class SecurityScheme < Vintage::Swagger::Object # https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#securitySchemeObject
        swagger_attr :type, :description, :name, :in, :flow, :authorizationUrl, :tokenUrl, :scopes

        def self.parse(security)
          return nil unless security

          Vintage::Swagger::Objects::ecurityScheme.new.bulk_set(security)
        end

        def type=(new_type)
          raise ArgumentError.new('Security::Data::ecurityScheme#type= - type is nil') unless new_type
          raise ArgumentError.new("Security::Data::ecurityScheme#type= - unrecognized type #{new_type}") unless %w(basic apiKey oauth2).include?(new_type)

          @type = new_type
        end

        def name=(new_name)
          raise ArgumentError.new('Security::Data::ecurityScheme#name= - name is nil') if @type == 'apiKey' && !new_name

          @name = new_name
        end

        def in=(new_in)
          if @type == 'apiKey'
            raise ArgumentError.new('Security::Data::ecurityScheme#in= - in is nil') unless new_in
            raise ArgumentError.new("Security::Data::ecurityScheme#in= - unrecognized in #{new_in}") unless %w(query header).include?(new_in)
          end

          @in = new_in
        end

        def flow=(new_flow)
          if @type == 'oauth2'
            raise ArgumentError.new('Security::Data::ecurityScheme#flow= - flow is nil') unless new_flow
            raise ArgumentError.new("Security::Data::ecurityScheme#flow= - unrecognized flow #{new_flow}") unless %w(implicit password application accessCode).include?(new_flow)
          end

          @flow = new_flow
        end

        def authorizationUrl=(new_authorizationUrl)
          raise ArgumentError.new('Security::Data::ecurityScheme#authorizationUrl= - authorizationUrl is nil') if @type == 'oauth2' && (@flow == 'implicit' || @flow == 'accessCode') && !new_authorizationUrl

          @authorizationUrl = new_authorizationUrl
        end

        def tokenUrl=(new_tokenUrl)
          raise ArgumentError.new('Security::Data::ecurityScheme#tokenUrl= - tokenUrl is nil') if @type == 'oauth2' && (@flow == 'password' || @flow == 'application' || @flow == 'accessCode') && !new_tokenUrl

          @tokenUrl = new_tokenUrl
        end

        def scopes=(new_scopes)
          raise ArgumentError.new('Security::Data::ecurityScheme#scopes= - scopes is nil') if @type == 'oauth2' && !new_scopes

          new_scopes = Vintage::Swagger::Objects::copes.parse(new_scopes) unless new_scopes.is_a?(Vintage::Swagger::Objects::copes)

          @scopes = new_scopes
        end
      end
    end
  end
end
