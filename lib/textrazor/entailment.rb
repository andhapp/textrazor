module TextRazor

  class Entailment

    extend Util

    attr_reader :id, :word_positions, :prior_score, :context_score,
                :score, :entailed_tree, :entailed_words

    def initialize(params = {})
      @type = []
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
