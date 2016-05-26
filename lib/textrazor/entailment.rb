module TextRazor

  class Entailment

    include Util

    attr_reader :id, :word_positions, :prior_score, :context_score,
                :score, :entailed_tree, :entailed_words

    def initialize(params = {})
      @type = []
      initialize_params params
    end

  end

end
