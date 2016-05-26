module TextRazor

  class Property

    include Util

    attr_reader :id, :word_positions, :property_positions

    def initialize(params = {})
      initialize_params params
    end

  end

end
