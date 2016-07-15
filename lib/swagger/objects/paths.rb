require 'vintage/swagger/object'
require 'vintage/swagger/objects/path'

module Vintage
  module Swagger
    module Objects
      class Paths < Vintage::Swagger::Object # https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#pathsObject
        def initialize
          @paths = {}
        end

        def self.parse(paths)
          raise ArgumentError.new('Vintage::Swagger::Objects::Paths#parse - paths object is nil') unless paths
          raise ArgumentError.new('Vintage::Swagger::Objects::Paths#parse - paths object is not an hash') unless paths.is_a?(Hash)

          pts = Vintage::Swagger::Objects::Paths.new

          paths.each do |path, path_obj|
            pts.add_path(path, path_obj)
          end

          pts
        end

        def add_path(path, path_obj)
          raise ArgumentError.new('Vintage::Swagger::Objects::Paths#parse - path is nil') if path.nil? || path.empty?
          raise ArgumentError.new('Vintage::Swagger::Objects::Paths#parse - path object is nil') if path_obj.nil?

          unless path_obj.is_a?(Vintage::Swagger::Objects::Path)
            path_obj = Vintage::Swagger::Objects::Path.parse(path_obj)
          end

          @paths[path] = path_obj
        end

        def all_paths
          @paths.values
        end

        def [](path)
          @paths[path]
        end

        def to_swagger
          swag_obj = {}

          @paths.each do |path, path_obj|
            swag_obj[path] = path_obj.to_swagger
          end

          swag_obj
        end
      end
    end
  end
end
