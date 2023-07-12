module MastodonCommand
  class LangConverter < MastodonCommand::Converter
    def convert(input)
      @replaces.each do |replace|
        input = input.gsub(/#{replace[:pattern]}/, replace[:replace])
      end
      input
    end
  end
end
