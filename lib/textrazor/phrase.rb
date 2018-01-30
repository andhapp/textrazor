module TextRazor

  class Phrase
    include TextRazor::Util

    attr_reader :id, :text

    def initialize(params, words)
      params = initialize_params params
      @id    = params["id"]
      @text  = match_words(params["wordPositions"], words)
    end

    def self.create_from_hash(params, words)
      new(params, words)
    end

    def match_words(positions, words)
      phrase = []
      positions.each { |position| phrase.push words[position].token }
      phrase.join(' ')
    end
  end

end
