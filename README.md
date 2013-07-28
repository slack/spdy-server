# spdy-server

spdy-server is a small SPDY server copied from [https://github.com/igrigorik/spdy](https://github.com/igrigorik/spdy)

I extracted this to have a simple an easily deployable SPDY server.

## Setup

Run `bundle install && bundle exec ruby spdy-server.rb`

spdy-server will be listing on [http://localhost:10000](localhost:10000)

## Using SSL

By default Chrome will use SSL+SPDY, if you have put this server behind an SSL proxy launch Google Chrome (or Canary) with:

    /Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome \Canary --use-spdy=ssl

## Using without SSL

If you want to simply test SPDY with vanilla HTTP:

    /Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome \Canary --use-spdy=no-ssl

### License

MIT License - Copyright (c) 2011 Ilya Grigorik
