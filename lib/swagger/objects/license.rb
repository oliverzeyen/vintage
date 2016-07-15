require 'vintage/swagger/objects/url'
require 'vintage/swagger/object'

module Vintage
  module Swagger
    module Objects
      class License < Vintage::Swagger::Object # https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#license-object
        DEFAULT_NAME = 'Apache 2.0'.freeze
        DEFAULT_URL = 'http://www.apache.org/licenses/LICENSE-2.0.html'.freeze

        swagger_attr :name, :url

        def initialize
          @name = DEFAULT_NAME
          @url = Vintage::Swagger::Objects::Url.new(DEFAULT_URL)
        end

        def self.parse(license)
          return nil unless license

          Vintage::Swagger::Objects::License.new.bulk_set(license)
        end

        def name=(new_name)
          raise ArgumentError.new('Vintage::Swagger::Objects::License - license name is invalid ') if new_name.nil? || new_name.empty?
          @name = new_name
        end

        def url=(url)
          return nil unless url

          @url = Vintage::Swagger::Objects::Url.new(url)
          validate_url!
          @url
        end

        def url
          @url.url
        end

        def valid?
          @url.valid?
        end

        private

        def validate_url!
          raise ArgumentError.new('Vintage::Swagger::Objects::License - contact url is invalid') unless @url.valid?
        end
      end
    end
  end
end
