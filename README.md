= postalmethods

[![Build
Status](https://travis-ci.org/chip/postalmethods.svg?branch=wip-rspec-api-key)](https://travis-ci.org/chip/postalmethods)

* Info: http://www.postalmethods.com/resources/quickstart
* Code: http://github.com/imajes/postalmethods/tree/master

== DESCRIPTION:

API wrapper library for the postal methods api.

== FEATURES/PROBLEMS:

* Provides access to all of the API methods with appropriate 
  exceptions as necessary.

== SYNOPSIS:

```ruby
require 'postalmethods'

@doc = open(File.dirname(__FILE__) + '/../spec/doc/sample.pdf')
@client = PostalMethods::Client.new(:user => "user", :password => "password")
rv = @client.send_letter(@doc, "description of doc")
puts rv
```

== REQUIREMENTS:

* This gem relies on the soap4r gem.

== INSTALL:

* get a developer account at postalmethods.com
* add to your Gemfile:

```
gem "postalmethods", git: "https://github.com/chip/postalmethods.git"
```

* edit .env-example to use your API key and credentials from
  postalmethods.com
* source .env-example


== LICENSE:

* See License.txt
