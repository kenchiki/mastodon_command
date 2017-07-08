module MastodonCommand
  class Random < MastodonCommand::Convert

    def convert(input)
      input + "\nあなたの運勢は「" + @replaces.sample + '」です'
    end
  end
end
