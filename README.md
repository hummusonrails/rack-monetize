# Rack Web Monetization Middleware

[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-v2.0%20adopted-ff69b4.svg)](CODE_OF_CONDUCT.md)
[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](./LICENSE.txt)
![Actions Status](https://github.com/benhayehudi/rack-monetize/workflows/CI/badge.svg)
[![Gem Version](https://badge.fury.io/rb/rack-monetize.svg)](https://badge.fury.io/rb/rack-monetize)

The Rack Web Monetization Middleware offers support for handling status updates from the [Web Monetization API](https://webmonetization.org/docs/getting-started).

The middleware will process the status updates sent from a client, and if it is a valid status update it will pass it through the rest of the stack. If it is not a valid status then it will return a `403` HTTP status code to the application.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-monetize'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-monetize

## Usage

You can use `rack-monetize` either in a standalone application or mounted into a Rails application.

### As a standalone application

Install the gem on your system:

``` shell
$ gem install rack-monetize
```

Then require it from within your `config.ru` Rack configuration:

``` ruby
use Rack::Monetize::ProcessMonetizeState
```

An example [config.ru](examples/config.ru.example) can be found in the examples folder. More information on getting up and running with Rack can be found at the [Rack GitHub repository](https://github.com/rack/rack/wiki/(tutorial)-rackup-howto#with-a-ru-config-file).

### Mounted into a Rails Application

Require it in your `Gemfile`:

```ruby
gem rack-monetize
```

And then add the middleware to your `config/application.rb` file to initialize it with your application:

```ruby
config.middleware.use Rack::Monetize::ProcessMonetizeState
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/benhayehudi/rack-monetize. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Rack::Monetize project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/benhayehudi/rack-monetize/blob/master/CODE_OF_CONDUCT.md).
