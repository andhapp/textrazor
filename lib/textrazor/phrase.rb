module TextRazor

  class Phrase
    attr_reader :id, :text

    def initialize(params, words)
      @id    = params["id"]
      @text  = match_words(params["wordPositions"], words)
    end

    def match_words(positions, words)
      phrase = []
      positions.each { |position| phrase.push words[position].token }
      phrase.join(' ')
    end
  end

end
