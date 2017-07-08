module MastodonCommand
  class Lang < MastodonCommand::Convert

    def convert(input)
      @replaces.each {|replace|
        input = input.gsub(/#{replace[:pattern]}/, replace[:replace])
      }
      input
    end
  end
end
