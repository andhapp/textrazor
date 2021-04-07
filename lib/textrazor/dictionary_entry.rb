module TextRazor

  class DictionaryEntry

    include Util

    attr_reader :id, :text, :data

    def initialize(params = {})
      initialize_params params
    end

    def to_h
      {
        "id" => id,
        "text" => text,
        "data" => data
      }.reject { |_, v| v.nil? || v.empty? }
    end

    def valid?
      !text.nil? && !text.empty?
    end

  end
end

