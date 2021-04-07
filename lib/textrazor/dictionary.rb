module TextRazor

  class Dictionary

    include Util

    attr_reader :id, :match_type, :case_insensitive, :language

    def initialize(params = {})
      initialize_params params
    end

    def to_h
      {
        "matchType" => match_type,
        "caseInsensitive" => case_insensitive,
        "language" => language
      }.reject { |_, v| v.nil? }
    end

    def valid?
      !id.nil? && !id.empty?
    end

  end

end
