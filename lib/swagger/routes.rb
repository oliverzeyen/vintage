require 'swagger/route_path'
require 'swagger/route_settings'
require 'swagger/objects/paths'
require 'swagger/objects/path'

module Vintage
  module Grape
    class Routes
      attr_reader :types, :scopes

      def initialize(routes)
        @routes = routes
        @types = []
        @scopes = []
      end

      def to_swagger
        swagger = Vintage::Data::Paths.new
        paths = {}

        @routes.each do |route|
          route_settings = Vintage::Grape::RouteSettings.new(route)
          next if route_settings.hidden == true # implement custom "hidden" extension

          swagger_path_name = swagger_path_name(route)
          paths[swagger_path_name] ||= Vintage::Grape::RoutePath.new(swagger_path_name)
          paths[swagger_path_name].add_operation(route)
        end

        paths.each do |path_name, path|
          swagger.add_path(path_name, path.to_swagger)
          @types = (@types | path.types).uniq
          @scopes = (@scopes | path.scopes).uniq
        end

        swagger
      end

      private

      def swagger_path_name(grape_route)
        grape_path_name = grape_route.path
        grape_prefix = grape_route.prefix

        grape_path_name.gsub!(/^\/#{grape_prefix}/, '') if grape_prefix
        grape_path_name.gsub!(/^\/:version/, '') # remove api version - if any
        grape_path_name.gsub!(/\(\.:format\)$/, '') # remove api format - if any
        grape_path_name.gsub!(/\(\..+\)$/, '') # remove api format - if any
        grape_path_name.gsub!(/\/:([a-zA-Z0-9_]+)/, '/{\1}') # convert parameters from :format into {format}
        grape_path_name
      end
    end
  end
end
