# TextRazor

This is a gem wrapper for TextRazor REST API reference.

## Installation

Add this line to your application's Gemfile:

    gem 'text_razor'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install text_razor

## Usage

### When the client is persisted across different requests

```

client = TextRazor::Client.new('api_key')

response = client.analyse('text to be analysed')

response.topics # Returns an array of TextRazor::Topic instances.

response.entities # Returns an array of TextRazor::Entity instances.

```

### One off requests

For making one off request to retrieve topics, you can use the following
handy method. A new client is instantiated and discarded everytime you 
make this request.

```
TextRazor.topics('api_key', 'text')

TextRazor.entities('api_key', 'text')

```

## Next steps

Only implemented this for topics, and entities. Also, implement it for other
information that we can retrieve from the public API.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
