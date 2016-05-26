module TextRazor

  class Entity

    include Util

    attr_reader :id, :type, :matching_tokens, :entity_id, :freebase_types, :confidence_score,
      :wiki_link, :matched_text, :freebase_id, :relevance_score, :entity_english_id,
      :starting_pos, :ending_pos, :data, :wikidata_id

    def initialize(params = {})
      @type = []
      initialize_params params
    end

  end

end
