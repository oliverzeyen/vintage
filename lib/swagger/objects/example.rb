require 'vintage/swagger/object'

module Vintage
  module Swagger
    module Objects
      class Example < Vintage::Swagger::Object # https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#exampleObject
        attr_accessor :examples

        def initialize
          @examples = {}
        end

        def self.parse(new_examples)
          return nil unless new_examples

          ex_obj = Vintage::Swagger::Objects::Example.new

          examples = {}
          new_examples.each { |example_mime, example| examples[example_mime] = example }
          ex_obj.examples = examples

          ex_obj
        end

        def as_swagger
          @examples
        end
      end
    end
  end
end
