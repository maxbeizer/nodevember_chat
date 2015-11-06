# NodevemberChat

## Requirements
* [Elixir](http://elixir-lang.org/install.html)
  * [Erlang](https://www.erlang-solutions.com/downloads/download-erlang-otp)
* [Phoenix](http://www.phoenixframework.org/docs/installation)
* [Node](https://nodejs.org/en/download/)

## Steps
### Part I
```
$ mix phoenix.new nodevember_chat --no-ecto
$ iex -S mix phoenix.server
```

### Part II
Uncomment channel macro in `web/channels/user_socket.ex` to send "rooms:*"
messages to the RoomChannel.

### Part III
Add RoomChannel to `web/channels` and define a the join function
```elixir
defmodule NodevemberChat.RoomChannel do
  use Phoenix.Channel

  def join("rooms:lobby", _message, socket) do
    {:ok, socket}
  end
end
```

### Part IV
Ensure that socket.js gets loaded and tell the socket to join the "rooms:lobby"
channel/topic. Note the live code reloading and the join log in the console.

### Part V
Add jQuery and markup for chat. Add JS to push to channel and receive events
from channel.

### Part VI
Add the `handle_in` function in the RoomChannel to broadcast message to clients.
Also add the `handle_out` function for fun.

You could also broadcast to the chat from Iex via the Endpoint:
```elixir
NodevemberChat.Endpoint.broadcast! "rooms:lobby", "new_msg", %{body: "from Iex"}
```

### Part VII
Add the ` secret_key_base: System.get_env("SECRET_KEY_BASE")` to
`config/prod.exs` and remove call to the `config/prod.secret.exs` call at the
bottom of that file.

```
$ heroku apps:create nodevemberchat --buildpack https://github.com/hashnuke/heroku-buildpack-elixir
$ heroku buildpacks:add https://github.com/gjaldon/heroku-buildpack-phoenix-static.git
$ heroku config:set SECRET_KEY_BASE=somesecretkey
$ git push heroku master
$ herok apps:open
```

---

To start your Phoenix app:

  1. Install dependencies with `mix deps.get`
  2. Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: http://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
