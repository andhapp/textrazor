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

```

client = TextRazor::Client.new('api_key', {extractors: [], cleanup_html:
false, filter_dbpedia_types: [], filter_freebase_types: []})

response = client.analyse('text to be analysed')

response.topics # Returns an array of TextRazor::Topic instances.

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
