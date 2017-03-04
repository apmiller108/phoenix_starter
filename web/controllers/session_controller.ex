defmodule PhoenixStarter.SessionController do
  use    PhoenixStarter.Web, :controller

  alias PhoenixStarter.Auth

  plug :scrub_params, "session" when action in [:create]

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password} }) do

    case Auth.login_with_email_and_password(conn, email, password) do
      {:ok, conn} -> 
        conn
        |> put_flash(:info, "Logged in")
        |> redirect(to: page_path(conn, :index))
      {:error, _, conn} ->
        conn
        |> put_flash(:error, "Invalid email or password")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> Auth.logout
    |> put_flash(:info, "Logged out")
    |> redirect(to: page_path(conn, :index))
  end
end
