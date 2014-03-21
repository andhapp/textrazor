module TextRazor
  class Configuration
    attr_accessor :secure

    def initialize
      @secure = true
    end
  end
end