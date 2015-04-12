# Competition

Predicts how person will do in competition

It is an example how `protected` can be useful in Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'competition'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install competition

## Usage

```ruby
require "competition"
```

### Creating Competition object

```ruby
person_a = Competition::Person.new(intelligence: 33, willpower: 20)
person_b = Competition::Person.new(intelligence: 47, willpower: 17)
person_c = Competition::Person.new(intelligence: 39, willpower: 25)

competition = Competition::Competition.new
competition << person_a
competition << person_b
competition << person_c
```

### Determining person predicted rating

```ruby
person_a.in_competition(competition).predicted_rating  #=> 45.009699999999995
```

## How it works

```
rating = affected_intelligence + 0.5 * affected_willpower, where:
affected_intelligence = intelligence * (1.03 ** more_intelligent_opponent_count)
affected_willpower = willpower * (0.97 ** less_intelligent_opponent_count)
```

## Contributing

1. Fork it ( https://github.com/waterlink/competition/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
