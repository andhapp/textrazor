# TextRazor

This is a gem wrapper for TextRazor REST API reference.

## Code status

[![Build Status](https://travis-ci.org/andhapp/textrazor.svg?branch=master)](https://travis-ci.org/andhapp/textrazor)

## Installation

Add this line to your application's Gemfile:

    gem 'textrazor'

And then execute:

    $ bundle

Or download the git repository and install it yourself as:

    $ gem build textrazor.gemspec
    $ gem install textrazor-[version].gem

## Usage

### Configuration

By default TextRazor uses the secure SSL endpoint of the Text Razor API.
You can use the HTTP endpoint by configuring TextRazor:

```
TextRazor.configure do |config|
  config.secure = false
end
```

You can also force TextRazor to use the European API endpoint if your account
supports it. You can find more information about this feature in [this blog
post](https://www.textrazor.com/blog/2018/11/new-region-textrazor-eu.html).

```
TextRazor.configure do |config|
  config.use_europe_endpoint = true
end
```

### When the client is persisted across different requests

```

client = TextRazor::Client.new('api_key')

response = client.analyse('text to be analysed')

response.topics # Returns an array of TextRazor::Topic instances.

response.coarse_topics # Returns an array of TextRazor::Topic instances.

response.entities # Returns an array of TextRazor::Entity instances.

response.words # Returns an array of TextRazor::Word instances.

response.phrases # Returns an array of TextRazor::Phrase instances.

```

### One off requests

For making one off request to retrieve topics, entities or words you
can use the following handy method. A new client is instantiated and
discarded everytime you make this request.

```
TextRazor.topics('api_key', 'text')

TextRazor.coarse_topics('api_key', 'text')

TextRazor.entities('api_key', 'text')

TextRazor.words('api_key', 'text')

TextRazor.phrases('api_key', 'text')

```

## Next steps

Only implemented this for topics, entities, words and phrases. Also, implement
it for other information that we can retrieve from the public API.

### API Issues (To investigate)

#### Response

* error - Descriptive error message of any problems that may have occurred during analysis, or an empty string if there was no error.

Missing from the successful response.

* message - Any warning or informational messages returned from the server, or an empty string if there was no message.

Missing from the successful response.

* cleanedText

Missing from the successful response.

* customAnnotationOutput

Missing from the successful response.

### Specs

#### Prolog rules

Specs around custom prolog rules need to be added.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
