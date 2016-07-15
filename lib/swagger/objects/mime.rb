module Vintage
  module Swagger
    module Objects
      class Mime
        @@types = [
          'text/plain',
          'text/json',
          'text/plain; charset=utf-8',
          'application/json',
          'application/hal+json',
          'application/problem+json',
          'application/postscript',
          'application/pdf',
          'application/postscript',
          'application/octet-stream',
          'application/xml',
          'application/zip',
          'text/xml',
          'text/tab-separated-values',
          'application/vnd.api+json',
          'application/vnd.github+json',
          'application/vnd.github.v3+json',
          'application/vnd.github.v3.raw+json',
          'application/vnd.github.v3.text+json',
          'application/vnd.github.v3.html+json',
          'application/vnd.github.v3.full+json',
          'application/vnd.github.v3.diff',
          'application/vnd.github.v3.patch'
        ]

        def self.valid?(type)
          @@types.include?(type)
        end
      end
    end
  end
end
