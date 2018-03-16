# Rcopy

Copy redis databases from one host/db to another.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rcopy'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rcopy

## Usage

  To copy a single redis db:
    Rcopy::Copier.new(Redis.new(...)).copy_to(Redis.new(...))

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/omadahealth/rcopy.
