require 'lib/objects/document'

module Vintage
  module Swagger
    class Base
      def self.generate
        swagger_doc = Vintage::Swagger::Objects::Document.new

        swagger_doc.host = 'localhost:80'
        swagger_doc.basePath = '/api/v1'

        swagger_doc.schemes = %w(https http)
        swagger_doc.produces = ['application/json']
        swagger_doc.consumes = ['application/json']

        swagger_doc.info.contact = Vintage::Swagger::Objects::Contact.new
        swagger_doc.info.license = Vintage::Swagger::Objects::License.new
        swagger_doc.info.termsOfService = 'https://localhost/tos.html'

        swagger_doc
      end
    end
  end
end
