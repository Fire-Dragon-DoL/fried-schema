# Fried::Schema [![Build Status][test-badge]][test-link]

Struct definition with type safety

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fried-schema'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fried-schema

## Usage

Two modules are exposed:

- `Fried::Schema::Struct`
- `Fried::Schema::DataEntity`

### Struct

```ruby
class Person
  include Fried::Schema::Struct

  # attribute_name, type_checking, default_value (optional)
  # default value could be anything. However if it's a Proc, it will be
  # evaluated at initialization
  attribute :name, String, default: ""
  attribute :born_at, Time, default: -> { Time.now }
  attribute :age, Numeric
end

person = Person.new
person.name = "John"

person.name # => "John"
person.born_at # => 2017-11-24 00:55:50 -0800
person.age # => nil

person.name = 123 # raises TypeError
```

### DataEntity

Has all the same functionality as `Fried::Schema::Struct`, in addition to
`#to_h` and `.build`

```ruby
class Person
  include Fried::Schema::DataEntity

  attribute :name, String, default: ""
  attribute :born_at, Time, default: -> { Time.now }
  attribute :age, Numeric
end

person = Person.build(name: "John", age: 123, not_present_key: "test")

person.name # => "John"
person.age # => 123

person.to_h # => { name: "John", born_at: 2017-11-24 00:55:50 -0800, age: 123 }
```

### Fried::Typings integration

The gem integrates with [fried-typings][fried-typings-link], you can use
those type as checks:

```ruby
class Person
  include Fried::Typings
  include Fried::Schema::DataEntity

  attribute :hobbies, ArrayOf[String], default: []
  attribute :something, OneOf[String, Numeric]
end

person = Person.build(hobbies: ["foo", "bar"])

person.hobbies # => ["foo", "bar"]
person.hobbies = [123, "foo"] # => raises TypeError
person.hobbies = []
person.hobbies # => []
person.hobbies = ["test"]
person.hobbies # => ["test"]

person.something = "foo"
person.something # => "foo"
person.something = 123
person.something # => 123
person.something = nil # => raises TypeError
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Fire-Dragon-DoL/fried-schema.

[test-badge]: https://travis-ci.org/Fire-Dragon-DoL/fried-schema.svg?branch=master
[test-link]: https://travis-ci.org/Fire-Dragon-DoL/fried-schema
[fried-typings-link]: https://github.com/Fire-Dragon-DoL/fried-typings
