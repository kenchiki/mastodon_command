# MastodonCommand

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/mastodon_command`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mastodon_command'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mastodon_command

## Usage

- Make initializers file  
config\initializers\mastodon_command.rb

```ruby
MastodonCommand.setup do |status|
  # おみくじ機能
  fortune = MastodonCommand::Random.new('[ 　\n]?#(おみくじ|占い|運勢)[ 　\n]?', %w(大吉 中吉 小吉 吉 半吉 凶 大凶))
  status = fortune.convert(status) if fortune.match(status)

  # 大阪弁機能
  osaka = MastodonCommand::Lang.new('[ 　\n]?#(大阪弁)[ 　\n]?', [
    {
      pattern: 'です',
      replace: 'やで'
    },
    {
      pattern: 'する',
      replace: 'しよる'
    },
    {
      pattern: 'だった',
      replace: 'やった'
    },
    {
      pattern: 'すごい',
      replace: 'えらい'
    },
    {
      pattern: '疲れた',
      replace: 'しんどい'
    },
    {
      pattern: 'ない',
      replace: 'あれへん'
    },
    {
      pattern: '(バカ|ばか)',
      replace: 'アホ'
    },

  ])
  status = osaka.convert(status) if osaka.match(status)
  status
end
```

- toot by mastodon

```text
すごい疲れた:joy: 
#おみくじ
#大阪弁
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/mastodon_command.
