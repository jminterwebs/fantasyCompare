# FantasyCompare

CLI gem that asks users for a position and week. It then displays the top 10 projected players for that week and asks user to pick a player for a more detailed view.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fantasyCompare'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fantasyCompare

Run from terminal with:

    fantasy-compare 

## Usage

Gem runs in a console where it first displays a list of fantasy football positions. The console then asks the user for an input(1-6) to pick a valid position and a fantasy football week. The console then displays a list of the 10 ten players for that position and their project points for the selected week. The console then asks the user to pick a player for a more detailed view of that player.

In the detail view the players status is displayed and the most recent note for that player. The console then ask's if an additional note should be displayed. If yes is selected notes can be displayed until there are no more. If no is selected or if there are no more notes the console finally asks if details for another position should be displayed. A yes input will start the program over and no input will exit.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jminterwebs/fantasyCompare. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
