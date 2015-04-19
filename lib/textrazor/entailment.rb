module TextRazor

  class Entailment

    attr_reader :id, :word_positions, :prior_score, :context_score,
                :score, :entailed_tree, :entailed_words
 
    def initialize(params)
      @id = params[:id]
      @word_positions = params[:wordPositions]
      @prior_score = params[:priorScore]
      @context_score = params[:contextScore]
      @score = params[:score]
      @entailed_tree = params[:entailedTree]
      @entailed_words = params[:entailedWords]
    end

    def self.create_from_hash(params)
      new(params)
    end
  end

end
