require 'json'
require 'yaml'
require 'vintage/swagger/objects/url'
require 'vintage/swagger/object'

module Vintage
  module Swagger
    module Objects
      class Contact < Vintage::Swagger::Object # https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#contactObject
        DEFAULT_NAME = 'John Doe'.freeze
        DEFAULT_EMAIL = 'john.doe@example.com'.freeze
        DEFAULT_URL = 'https://google.com/?q=john%20doe'.freeze

        swagger_attr :name, :email, :url

        def initialize
          @name = DEFAULT_NAME
          @email = DEFAULT_EMAIL
          @url = Vintage::Swagger::Objects::Url.new DEFAULT_URL
        end

        def self.parse(contact)
          return nil unless contact
          c = Vintage::Swagger::Objects::Contact.new.bulk_set(contact)
          c.validate_url!
          c
        end

        def url=(url)
          return nil unless url
          @url = Vintage::Swagger::Objects::Url.new(url)
        end

        def url
          @url.url
        end

        def valid?
          true
        end

        def validate_url!
          raise ArgumentError.new('Vintage::Swagger::Objects::Contact - contact url is invalid') if @url && !@url.valid?
        end
      end
    end
  end
end
