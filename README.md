# ryoba

[Nokogiri](https://rubygems.org/gems/nokogiri) utility methods.


## API

- [Nokogiri::XML::Node](https://www.rubydoc.info/gems/ryoba/Nokogiri/XML/Node)
  - [#content!](http://www.rubydoc.info/gems/ryoba/Nokogiri/XML/Node:content%21)
    - aliased as [#inner_text!](http://www.rubydoc.info/gems/ryoba/Nokogiri/XML/Node:inner_text%21)
    - aliased as [#text!](http://www.rubydoc.info/gems/ryoba/Nokogiri/XML/Node:text%21)
  - [#content?](http://www.rubydoc.info/gems/ryoba/Nokogiri/XML/Node:content%3F)
    - aliased as [#inner_text?](http://www.rubydoc.info/gems/ryoba/Nokogiri/XML/Node:inner_text%3F)
  - [#matches!](http://www.rubydoc.info/gems/ryoba/Nokogiri/XML/Node:matches%21)
  - [#uri](http://www.rubydoc.info/gems/ryoba/Nokogiri/XML/Node:uri)
- [Nokogiri::XML::Searchable](https://www.rubydoc.info/gems/ryoba/Nokogiri/XML/Searchable)
  - [#ancestor](http://www.rubydoc.info/gems/ryoba/Nokogiri/XML/Searchable:ancestor)
  - [#ancestor!](http://www.rubydoc.info/gems/ryoba/Nokogiri/XML/Searchable:ancestor%21)
  - [#ancestors!](http://www.rubydoc.info/gems/ryoba/Nokogiri/XML/Searchable:ancestors%21)
  - [#at!](http://www.rubydoc.info/gems/ryoba/Nokogiri/XML/Searchable:at%21)
  - [#search!](http://www.rubydoc.info/gems/ryoba/Nokogiri/XML/Searchable:search%21)


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

Run `rake test` to run the tests.  You can also run `rake irb` for an
interactive prompt that pre-loads the project code.


## License

[MIT License](https://opensource.org/licenses/MIT)
