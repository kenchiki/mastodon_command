require "mastodon_command/version"
require "mastodon_command/convert"
require "mastodon_command/convert_random"
require "mastodon_command/convert_lang"
require "mastodon_command/statuses_controller"

module MastodonCommand
  def self.setup(&proc)
    # create function for Monkey patch
    extend self
    (
    class << self;
      self
    end).module_eval do
      define_method 'convert_toot', &proc
      # define_method 'b' do
      #   p 'b'
      # end
    end

    # Monkey patch
    Api::V1::StatusesController.prepend(ApiV1StatusesControllerPatch)
  end
end

