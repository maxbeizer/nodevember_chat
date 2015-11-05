defmodule NodevemberChat.RoomChannel do
  use Phoenix.Channel

  def join("rooms:lobby", _message, socket) do
    {:ok, socket}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast! socket, "new_msg", %{body: body}
    {:noreply, socket}
  end

  def handle_in("count", %{"body" => _}, socket) do
    Task.async fn ->
      body = WerdCounter.process_file_async(Path.join([System.cwd(), "/priv/static/war_and_peace.txt"]))
      broadcast! socket, "new_msg", %{body: body}
    end

    {:noreply, socket}
  end

  def handle_out("new_msg", payload, socket) do
    push socket, "new_msg", payload
    {:noreply, socket}
  end
end
