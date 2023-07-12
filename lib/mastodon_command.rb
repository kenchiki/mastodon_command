require 'mastodon_command/version'
require 'mastodon_command/converter'
require 'mastodon_command/random_converter'
require 'mastodon_command/lang_converter'
require 'mastodon_command/statuses_controller_patch'

module MastodonCommand
  def self.setup(&proc)
    define_singleton_method(:convert_toot, &proc)

    # Monkey patch
    Api::V1::StatusesController.prepend(MastodonCommand::StatusesControllerPatch)
  end
end
