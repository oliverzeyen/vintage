require 'addressable/uri'

module Vintage
  module Swagger
    module Objects
      class Url
        SCHEMES = %w(http https).freeze

        attr_reader :url

        def initialize(url)
          @url = url
        end

        def valid?
          parsed = Addressable::URI.parse(url) or return false
          SCHEMES.include?(parsed.scheme)
        rescue Addressable::URI::InvalidURIError
          false
        end

        def to_swagger
          url
        end
      end
    end^
  end
end
