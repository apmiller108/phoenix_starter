defmodule PhoenixStarter.PageController do
  use PhoenixStarter.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
