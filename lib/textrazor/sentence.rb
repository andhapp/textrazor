module TextRazor

  class Sentence 

    attr_reader :position, :words

    def initialize(params)
      @position = params[:position]
      @words = params[:words].map do |word_hash|
        Word.create_from_hash(word_hash)
      end
    end

    def number_of_words
      @words.size
    end
    
    def self.create_from_hash(params)
      new(params)
    end
    
  end

end
