module TextRazor

  class Category

    extend Util

    attr_reader :id, :category_id, :label, :score, :classifier_id

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
