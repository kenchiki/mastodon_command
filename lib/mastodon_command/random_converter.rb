module MastodonCommand
  class RandomConverter < MastodonCommand::Converter
    def convert(input)
      "#{input}\nあなたの運勢は「#{@replaces.sample}」です"
    end
  end
end
