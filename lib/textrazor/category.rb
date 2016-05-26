module TextRazor

  class Category

    include Util

    attr_reader :id, :category_id, :label, :score, :classifier_id

    def initialize(params = {})
      initialize_params params
    end

  end

end
