module TextRazor

  class Property

    extend Util

    attr_reader :id, :word_positions, :property_positions

    def initialize(params = {})
      params.each do |k, v|
        instance_variable_set(:"@#{k}", v) if v && self.respond_to?(:"#{k}")
      end
    end

    def self.create_from_hash(params)
      params = Hash[params.map {|k, v| [standardize(k), v] }]
      new(params)
    end

  end

end
