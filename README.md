# MastodonCommand
- おみくじ機能や大阪弁機能などをつけることができます。
- ローカルでマストドンのバージョン4.3.0にて動作を確認済み
（このプログラムを使って問題が起こっても保証はできないので予めご了承ください🙇‍♂️）

## Installation

```ruby
gem 'mastodon_command', '4.3.0'
```

## Usage

- 下記に設定ファイルを作成し、マストドンを再起動すると`#おみくじ`などのタグをつけてトゥートすることで動作確認できます


```ruby
# config\initializers\mastodon_command.rb

Rails.application.configure do
  config.after_initialize do
    MastodonCommand.setup do |status|
      # おみくじ機能
      fortune = MastodonCommand::RandomConverter.new('[ 　\n]?#(おみくじ|占い|運勢)[ 　\n]?', %w(大吉 中吉 小吉 吉 半吉 凶 大凶))
      status = fortune.convert(status) if fortune.match(status)

      # 大阪弁機能
      osaka = MastodonCommand::LangConverter.new('[ 　\n]?#(大阪弁)[ 　\n]?', [
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
  end
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

Bug reports and pull requests are welcome on GitHub at https://github.com/kenchiki/mastodon_command.
