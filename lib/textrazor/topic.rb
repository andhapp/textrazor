module TextRazor

  class Topic

    attr_reader :id, :label, :wiki_link, :score

    def initialize(params)
      @id = params[:id]
      @label = params[:label]
      @wiki_link = params[:wikiLink]
      @score = params[:score]
    end

    def self.create_from_hash(params)
      new(params)
    end

  end

end
