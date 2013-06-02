module TextRazor

  class Entity

    attr_reader :id, :matching_tokens, :entity_id, :freebase_types, :confidence_score, :wiki_link, :matched_text,
                :freebase_id, :relevance_score, :entity_english_id, :starting_pos, :ending_pos

    def initialize(params)
      @id = params["id"]
      @matching_tokens = params["matchingTokens"]
      @entity_id = params["entityId"]
      @freebase_types = params["freebaseTypes"]
      @confidence_score = params["confidenceScore"]
      @wiki_link = params["wikiLink"]
      @matched_text = params["matchedText"]
      @freebase_id = params["freebaseId"]
      @relevance_score = params["relevanceScore"]
      @entity_english_id = params["entityEnglishId"]
      @starting_pos = params["startingPos"]
      @ending_pos = params["endingPos"]
    end

    def self.create_from_hash(params)
      new(params)
    end

  end

end

