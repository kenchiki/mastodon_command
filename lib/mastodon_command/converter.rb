module MastodonCommand
  class Converter
    attr_accessor :pattern, :replaces

    def initialize(pattern, replaces)
      @pattern = pattern
      @replaces = replaces
    end

    def match(input)
      input.match(@pattern)
    end

    def convert(input)
      input
    end
  end
end
