defmodule PhoenixStarter.SessionController do
  use PhoenixStarter.Web, :controller

  plug :scrub_params, "session" when action in [:create]

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, session_params) do
  end

  def delete(conn, _) do
  end

  defp session_params do
    %{
      "session" => %{
        "email" => email, 
        "password" => password
      }
    }
  end
end
