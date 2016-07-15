require 'vintage/swagger/object'
require 'vintage/swagger/objects/contact'
require 'vintage/swagger/objects/license'

module Vintage
  module Swagger
    module Objects
      class Info < Vintage::Swagger::Object # https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#info-object
        DEFAULT_TITLE = 'My uber-duper API'.freeze
        DEFAULT_DESCRIPTION = 'My uber-duper API description'.freeze
        DEFAULT_VERSION = '0.1'.freeze

        swagger_attr :title, :description, :termsOfService, :contact, :license, :version

        def initialize
          @title = DEFAULT_TITLE
          @description = DEFAULT_DESCRIPTION
          @version = DEFAULT_VERSION
        end

        def self.parse(info)
          raise ArgumentError.new('Vintage::Swagger::Objects::Info#parse - info object is nil') unless info

          Vintage::Swagger::Objects::Info.new.bulk_set(info)
        end

        def title=(new_title)
          raise ArgumentError.new('Vintage::Swagger::Objects::Info#title= - title is invalid') if new_title.nil? || new_title.empty?
          @title = new_title
        end

        def contact=(new_contact)
          return nil unless new_contact

          unless new_contact.is_a?(Vintage::Swagger::Objects::Contact)
            new_contact = Vintage::Swagger::Objects::Contact.parse(new_contact)
          end

          @contact = new_contact
        end

        def license=(new_license)
          return nil unless new_license

          unless new_license.is_a?(Vintage::Swagger::Objects::License)
            new_license = Vintage::Swagger::Objects::License.parse(new_license)
          end

          @license = new_license
        end

        def valid?
          @license.valid? && @contact.valid?
        end
      end
    end
  end
end
