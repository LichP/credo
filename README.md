credo
=====

A simple way to retain and use credentials.

Why?
----

Most of the time you don't want to keep usernames and passwords hanging around
in your application. When dealing with external services, you'll probably be
using OAuth and suchlike most of the time. However, every so often you'll
interact with something which doesn't support OAuth, and you may find yourself
not wanting to have to ask the user to resupply their credentials when a
session times out after only a few minutes. At the same time you don't want
to keep passwords hanging around in plain text, especially when you're
debugging and passwords might end up on screen.

Credo provides a simple way of storing credentials, keeping the password
encrypted until you need it.

Usage
-----

Basic usage is as follows:

```ruby
    require 'credo'
    
    credentials = Credo.new(username: 'user', password: 'pass')
    
    credentials.use do |username, password|
      # do something with username and password here      
    end
```

Here's an example of how you might use it when working with an imaginary web
service, let's call it Acme Service:

```ruby
  require 'credo'
  
  class AcmeService
    class SessionExpired < RuntimeError; end
    
    def initialize(username, password)
      @credentials = Credo.new(username: username, password: password)
      login
    end
  
    def login
      @credentials.use do |username, password|
        # Log in to Acme Service
        # ...
      end
    end
    
    def do_action(params)
      begin
        # Try performing an Acme Service action using supplied params
        # If the session expires, we expect SessionExpired to be raised
        # ...
      rescue SessionExpired
        # If we get here the session expired, so we log in and try again
        login
        retry
      end
    end
  end
```

### Using with _irb_

When using with _irb_ you can use the prompt parameter. This accepts `:console`
as an argument, which gives you an `Enter password:` prompt:

```ruby
    irb> credentials = Credo.new(username: 'user', prompt: :console)
    Enter password:
    => #<Credo:0x2777be0 ...>
    irb>
```

### Other parameters

By default, Credo will salt the encryption key using the username and a random
number. You can supply your own salt with the `:salt` parameter.

Contact and Contributing
------------------------

The homepage for this project is

http://github.com/LichP/credo

Any feedback, suggestions, etc are very welcome. If you have bugfixes and/or
contributions, feel free to fork, branch, and send a pull request.

Enjoy :-)

Phil Stewart, October 2012
