module TextRazor

  class Topic

    extend Util

    attr_reader :id, :label, :wiki_link, :score, :wikidata_id

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
