# Nunchaku [![travis build status](https://secure.travis-ci.org/sitevalidator/nunchaku.png?branch=master)](http://travis-ci.org/sitevalidator/nunchaku) [![Code Climate](https://codeclimate.com/github/sitevalidator/nunchaku/badges/gpa.svg)](https://codeclimate.com/github/sitevalidator/nunchaku) [![Dependency Status](https://gemnasium.com/sitevalidator/nunchaku.png)](https://gemnasium.com/sitevalidator/nunchaku)

Nunchaku is a Ruby client for the [Nu HTML Checker](https://github.com/validator/validator). It lets you easily check HTML markup of web pages, by querying a remote instance of the checker.

![Nunchaku image](https://dl.dropboxusercontent.com/u/2268180/nunchaku/Nunchaku.png "Nunchaku image taken from http://commons.wikimedia.org/wiki/File:Nunchaku.png")

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nunchaku'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nunchaku

## Usage

To check HTML on a web page, just pass it the URL to check, like this:

```ruby
checker = Nunchaku.check('http://example.com')
```

Then, you can check the JSON response like this:

```ruby
checker.raw # {
            #   "url": "http://example.com",
            #   "messages": [{
            #                  "type": "error",
            #                  "lastLine": 73,
            #                  "lastColumn": 67,
            #                  "firstColumn": 64,
            #                  "message": "Stray end tag “a”.",
            #                  "extract": "idates</a></a></li>\n",
            #                  "hiliteStart": 10,
            #                  "hiliteLength": 4
            #                 }, (...)

```

Every message returned will also be accessible in a more friendly way like this:

```ruby
msg = checker.messages.first

msg.type          # "error"
msg.last_line     # 73
msg.first_column  # 64
msg.last_column   # 67
msg.message       # "Stray end tag “a”."
msg.extract       # "idates</a></a></li>\n"
msg.hilite_start  # 10
msg.hilite_length # 4
```

The `messages` array contains all messages returned by the checker, but you'll typically be more interested in `errors` (that contains all messages of type "error") and `warnings` (that contains all messages of subtype "warning").

## Using an alternate server

By default, Nunchaku will query the Nu HTML Checker at http://validator.w3.org/nu but you're encouraged to install your own instance and use it instead. You can follow the [Nu installation instructions](https://github.com/validator/validator) and then specify the alternate server like this:

```ruby
Nunchaku.check('http://example.com', checker_uri: 'http://yourchecker.com')
```

## Specifying a custom User-Agent string

If you want to specify a custom User-Agent string so that the Nu HTML Checker presents itself as another agent, you can do it like this:

```ruby
Nunchaku.check('http://example.com', user_agent: 'Mozilla/5.0 (Windows NT 6.3; rv:36.0) Gecko/20100101 Firefox/36.0')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

To run the specs, run `bundle exec rake`.

## Contributing

1. Fork it ( https://github.com/sitevalidator/nunchaku/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
