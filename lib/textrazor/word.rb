module TextRazor

  class Word

    attr_reader :position,
                :starting_pos,
                :ending_pos,
                :stem,
                :lemma,
                :token,
                :part_of_speech,
                :parent_position

    def initialize(params)
      @position         = params["position"]
      @starting_pos     = params["startingPos"]
      @ending_pos       = params["endingPos"]
      @stem             = params["stem"]
      @lemma            = params["lemma"]
      @token            = params["token"]
      @part_of_speech   = params["partOfSpeech"]
      @parent_position  = params["parentPosition"]
    end

    def self.create_from_hash(params)
      new(params)
    end

  end

end
