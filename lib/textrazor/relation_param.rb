module TextRazor

  class RelationParam

    attr_reader :relation, :word_positions

    def initialize(params = {})
      @relation = params[:relation]
      @word_positions = params[:wordPositions]
    end

    def self.create_from_hash(params)
      new(params)
    end

  end

end
