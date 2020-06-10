![Run tests](https://github.com/driggl/fast_cqrs/workflows/Run%20tests/badge.svg?branch=master&event=push)
[![Gem Version](https://badge.fury.io/rb/fast_cqrs.svg)](https://badge.fury.io/rb/fast_cqrs)

# FastCqrs

A collection of small classes allowing to implement CQRS API in ruby applications without too much of an effort.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fast_cqrs'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install fast_cqrs

## Usage

### Transactions

`FastCqrs` delivers transactions as the main piece of the request processing. A whole request processing is
encapsulated within the transaction object, so it's easy to write unit tests for your endpoints without loading
the whole framework while testing.

Also, it's super easy to inject dependencies when needed.

Basic transaction could look like this.

```ruby
   # transactions/create_article.rb

  class CreateArticle < FastCqrs::Transaction
    def call(params, **)
      model = yield deserialize(params)
      yield authorize(model)
      yield create_article(model)
      Success()
    end

    private

    def deserialize(params)
      request.call(params)
    end

    def authorize(model)
      authorizer.call(params)
    end

    def create_article(model)
      Try { Article.create!(model) }
    end

    def initialize
      @authorizer = Authorizer.new
      @request = Request.new
    end
  end
```

```ruby
  # articles_controller

  def create
    Transactions::CreateArticle.new.call(params)
  end

  def create
    Transactions::UpdateArticle.new.call(params)
  end

```

### Transaction blocks

Typical transaction consists of:

- request - This parses the request body and modifies the input for an easy to use output.
- authorizer - authorizes the parsed input against the given auth object
- validator - validates the request
- actions - methods making changes in the system.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/driggl/fast_cqrs. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/driggl/fast_cqrs/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the FastCqrs project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/driggl/fast_cqrs/blob/master/CODE_OF_CONDUCT.md).
