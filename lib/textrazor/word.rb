module TextRazor

  class Word

    extend Util

    attr_reader :position, :starting_pos, :ending_pos, :stem, :lemma, 
                :token, :part_of_speech, :parent_position

    def initialize(params = {})
      @type = []
      params.each do |k, v|
        instance_variable_set(:"@#{k}", v) if v && self.respond_to?(:"#{k}")
      end
    end

    def self.create_from_hash(params)
      params = Hash[params.map {|k, v| [standardize(k), v] }]
      new(params)
    end

  end

end
