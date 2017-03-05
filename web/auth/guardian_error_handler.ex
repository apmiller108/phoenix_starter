defmodule PhoenixStarter.GuardianErrorHandler do
  import PhoenixStarter.Router.Helpers

  def unauthenticated(conn, _params) do
    conn
    |> Phoenix.Controller.put_flash(:error, "Login required")
    |> Phoenix.Controller.redirect(to: session_path(conn, :new))
  end
end
