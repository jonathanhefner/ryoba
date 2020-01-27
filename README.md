# ryoba [![Build Status](https://travis-ci.org/jonathanhefner/ryoba.svg?branch=master)](https://travis-ci.org/jonathanhefner/ryoba)

[Nokogiri](https://rubygems.org/gems/nokogiri) utility methods.


## API

- [Nokogiri::XML::Document](https://www.rubydoc.info/gems/ryoba/Nokogiri/XML/Document)
  - [#uri](https://www.rubydoc.info/gems/ryoba/Nokogiri/XML/Document:uri)
- [Nokogiri::XML::Node](https://www.rubydoc.info/gems/ryoba/Nokogiri/XML/Node)
  - [#content!](https://www.rubydoc.info/gems/ryoba/Nokogiri/XML/Node:content%21)
    - aliased as [#inner_text!](https://www.rubydoc.info/gems/ryoba/Nokogiri/XML/Node:inner_text%21)
    - aliased as [#text!](https://www.rubydoc.info/gems/ryoba/Nokogiri/XML/Node:text%21)
  - [#content?](https://www.rubydoc.info/gems/ryoba/Nokogiri/XML/Node:content%3F)
    - aliased as [#inner_text?](https://www.rubydoc.info/gems/ryoba/Nokogiri/XML/Node:inner_text%3F)
  - [#matches!](https://www.rubydoc.info/gems/ryoba/Nokogiri/XML/Node:matches%21)
  - [#uri](https://www.rubydoc.info/gems/ryoba/Nokogiri/XML/Node:uri)
- [Nokogiri::XML::Searchable](https://www.rubydoc.info/gems/ryoba/Nokogiri/XML/Searchable)
  - [#ancestor](https://www.rubydoc.info/gems/ryoba/Nokogiri/XML/Searchable:ancestor)
  - [#ancestor!](https://www.rubydoc.info/gems/ryoba/Nokogiri/XML/Searchable:ancestor%21)
  - [#ancestors!](https://www.rubydoc.info/gems/ryoba/Nokogiri/XML/Searchable:ancestors%21)
  - [#at!](https://www.rubydoc.info/gems/ryoba/Nokogiri/XML/Searchable:at%21)
  - [#search!](https://www.rubydoc.info/gems/ryoba/Nokogiri/XML/Searchable:search%21)


## Installation

Install from [Ruby Gems](https://rubygems.org/gems/ryoba):

```bash
$ gem install ryoba
```

Then require in your Ruby script:

```ruby
require "ryoba"
```


## Contributing

Run `rake test` to run the tests.


## License

[MIT License](https://opensource.org/licenses/MIT)
