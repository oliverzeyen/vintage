require 'json'
require 'vintage/swagger/object'
require 'vintage/swagger/objects/info'
require 'vintage/swagger/objects/mime'
require 'vintage/swagger/objects/paths'
require 'vintage/swagger/objects/definitions'
require 'vintage/swagger/objects/parameters'
require 'vintage/swagger/objects/responses'
require 'vintage/swagger/objects/security_definitions'
require 'vintage/swagger/objects/security_requirement'
require 'vintage/swagger/objects/tag'
require 'vintage/swagger/objects/external_documentation'

module Vintage
  module Swagger
    module Objects
      class Document < Vintage::Swagger::Object # https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#swagger-object
        SPEC_VERSION = '2.0'.freeze # https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#fixed-fields
        DEFAULT_HOST = 'localhost:80'.freeze

        swagger_attr :swagger, :info, :host, :basePath, :schemes, :consumes,
                     :produces, :paths, :definitions, :parameters, :responses, :securityDefinitions,
                     :security, :tags, :externalDocs

        # create an empty document
        def initialize
          @swagger = '2.0'
          @info = Vintage::Swagger::Objects::Info.new
          @paths = Vintage::Swagger::Objects::Paths.new
        end

        # parse an hash document into a set of Swagger objects
        #   document is a hash
        def self.parse(document)
          raise ArgumentError.new('Vintage::Document#parse - document object is nil') unless document

          Vintage::Swagger::Objects::Document.new.bulk_set(document)
        end

        def swagger=(new_swagger)
          raise ArgumentError.new("Vintage::Document#swagger= - the document is not a swagger #{SPEC_VERSION} version") unless '2.0' == new_swagger
          @swagger = new_swagger
        end

        def info=(new_info)
          raise ArgumentError.new('Vintage::Document#info= - info object is nil') unless new_info

          new_info = Vintage::Swagger::Objects::Info.parse(new_info) unless new_info.is_a?(Vintage::Swagger::Objects::Info)

          @info = new_info
        end

        def basePath=(new_path)
          new_path = new_path.nil? ? '/' : new_path

          unless new_path =~ /^\/.+$/
            new_path = "/#{new_path}" # new path must start with a /
          end

          @basePath ||= new_path
        end

        def schemes=(new_schemes)
          return nil unless new_schemes

          new_schemes.each do |scheme|
            raise ArgumentError.new("Vintage::Swagger::Objects::Document#schemes= - unrecognized scheme #{scheme}") unless %w(http https ws wss).include?(scheme)
          end

          @schemes = new_schemes
        end

        def produces=(new_produces)
          return nil unless new_produces

          new_produces.each do |produce|
            raise ArgumentError.new("Vintage::Swagger::Objects::Document#produces= - unrecognized produce type #{produce}") unless Vintage::Swagger::Objects::Mime.valid?(produce)
          end

          @produces = new_produces
        end

        def consumes=(new_consumes)
          return nil unless new_consumes

          new_consumes.each do |consume|
            raise ArgumentError.new("Vintage::Swagger::Objects::Document#consumes= - unrecognized consume type #{consume}]") unless Vintage::Swagger::Objects::Mime.valid?(consume)
          end

          @consumes = new_consumes
        end

        def paths=(new_paths)
          raise ArgumentError.new('Vintage::Swagger::Objects::Document#paths= - paths is nil') unless paths

          new_paths = Vintage::Swagger::Objects::Paths.parse(new_paths) unless new_paths.is_a?(Vintage::Swagger::Objects::Paths)

          @paths = new_paths
        end

        def definitions=(new_definitions)
          return nil unless new_definitions

          unless new_definitions.is_a?(Vintage::Swagger::Objects::Definitions)
            new_definitions = Vintage::Swagger::Objects::Definitions.parse(new_definitions)
          end

          @definitions = new_definitions
        end

        def parameters=(new_parameters)
          return nil unless new_parameters

          unless new_parameters.is_a?(Vintage::Swagger::Objects::Parameters)
            new_parameters = Vintage::Swagger::Objects::Parameters.parse(new_parameters)
          end

          @parameters = new_parameters
        end

        def responses=(new_responses)
          return nil unless new_responses

          unless new_responses.is_a?(Vintage::Swagger::Objects::Responses)
            new_responses = Vintage::Swagger::Objects::Responses.parse(new_responses)
          end

          @responses = new_responses
        end

        def securityDefinitions=(newSecurityDef)
          return nil unless newSecurityDef

          unless newSecurityDef.is_a?(Vintage::Swagger::Objects::ecurityDefinitions)
            newSecurityDef = Vintage::Swagger::Objects::ecurityDefinitions.parse(newSecurityDef)
          end

          @securityDefinitions = newSecurityDef
        end

        def security=(new_security)
          return nil unless new_security

          @security = []

          new_security.each do |sec_object|
            unless sec_object.is_a?(Vintage::Swagger::Objects::ecurityRequirement)
              sec_object = Vintage::Swagger::Objects::ecurityRequirement.parse(sec_object)
            end

            @security.push(sec_object)
          end
        end

        def tags=(new_tags)
          return nil unless new_tags

          @tags = []

          new_tags.each do |tag|
            add_tag(tag)
          end
        end

        def add_tag(new_tag)
          return nil unless new_tag

          unless new_tag.is_a?(Vintage::Swagger::Objects::Tag)
            new_tag = Vintage::Swagger::Objects::Tag.parse(new_tag)
          end

          @tags.push(new_tag)
        end

        def externalDocs=(new_externalDocs)
          return nil unless new_externalDocs

          unless new_externalDocs.is_a?(Vintage::Swagger::Objects::ExternalDocumentation)
            new_externalDocs = Vintage::Swagger::Objects::ExternalDocumentation.parse(new_externalDocs)
          end

          @externalDocs = new_externalDocs
        end
      end
    end
  end
end
