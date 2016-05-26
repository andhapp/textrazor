module TextRazor

  class Word
    include Util

    attr_reader :position, :starting_pos, :ending_pos, :stem, :lemma,
                :token, :part_of_speech, :parent_position

    def initialize(params = {})
      @type = []
      initialize_params params
    end

  end

end
