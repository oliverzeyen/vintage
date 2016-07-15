require 'swagger/method'
require 'swagger/route_settings'
require 'swagger/objects/path'
require 'swagger/objects/operation'

module Vintage
  module Grape
    class RoutePath
      attr_reader :types, :scopes

      def initialize(route_name)
        @name = route_name
        @operations = {}
        @types = []
        @scopes = []
      end

      def add_operation(route)
        method = Vintage::Grape::Method.new(@name, route)
        route_settings = Vintage::Grape::RouteSettings.new(route)
        grape_operation = method.operation
        @types = (@types | method.types).uniq
        @scopes = (@scopes | method.scopes).uniq
        @operations[route_settings.method.downcase] = grape_operation
      end

      def to_swagger
        path = Vintage::Data::Path.new

        @operations.each do |operation_verb, operation|
          path.send("#{operation_verb}=", operation)
        end

        path
      end
    end
  end
end
