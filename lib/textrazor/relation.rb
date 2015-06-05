module TextRazor

  class Relation

    attr_reader :id, :word_positions, :relation_params

    def initialize(params = {})
      @id = params[:id]
      @word_positions = params[:wordPositions]
      @relation_params = params[:params].map do |relation_param_hash|
        RelationParam.create_from_hash(relation_param_hash)
      end
    end

    def number_of_relation_params
      @relation_params.size
    end

    def self.create_from_hash(params)
      new(params)
    end

  end

end
