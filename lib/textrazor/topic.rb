module TextRazor

  class Topic

    include Util

    attr_reader :id, :label, :wiki_link, :score, :wikidata_id

    def initialize(params = {})
      initialize_params params
    end

  end

end
