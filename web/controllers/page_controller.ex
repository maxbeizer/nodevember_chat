defmodule NodevemberChat.PageController do
  use NodevemberChat.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
