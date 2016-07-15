require 'vintage/swagger/object'
require 'vintage/swagger/objects/parameter'

module Vintage
  module Swagger
    module Objects
      class Parameters < Vintage::Swagger::Object # https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#parametersDefinitionsObject
    def initialize
      @parameters = {}
    end

    def self.parse(parameters)
      return nil unless parameters

      params = Vintage::Swagger::Objects::Parameters.new

      parameters.each do |pname, pvalue|
        params.add_param(pname, pvalue)
      end

      params
    end

    def add_param(pname, pvalue)
      raise ArgumentError.new('Vintage::Swagger::Objects::Parameters#add_param - parameter name is nil') unless pname
      raise ArgumentError.new('Vintage::Swagger::Objects::Parameters#add_param - parameter value is nil') unless pvalue

      unless pvalue.is_a?(Vintage::Swagger::Objects::Parameter)
        pvalue = Vintage::Swagger::Objects::Parameter.parse(pvalue)
      end

      @parameters[pname] = pvalue
    end

    def [](pname)
      @parameters[pname]
    end

    def params
      @parameters.keys
    end

    def as_swagger
      swagger_params = {}

      @parameters.each do |p_k, p_v|
        swagger_params[p_k] = p_v.to_swagger
      end

      swagger_params
    end
  end
end
