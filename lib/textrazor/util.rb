module TextRazor
  module Util
    def self.included(base)
      base.extend ClassMethods

      base.class_eval do
        def initialize_params(params)
          params.each do |k, v|
            instance_variable_set(:"@#{k}", v) if self.respond_to?(:"#{k}") && v && (!v.is_a?(String) || !v.empty?)
          end
        end
      end
    end

    module ClassMethods
      def standardize(param)
        param.to_s.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        downcase
      end

      def create_from_hash(params)
        params = Hash[params.map {|k, v| [standardize(k), v] }]
        new(params)
      end
    end
  end
end
