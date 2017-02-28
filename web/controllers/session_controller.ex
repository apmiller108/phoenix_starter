defmodule PhoenixStarter.SessionController do
  use    PhoenixStarter.Web, :controller
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  alias PhoenixStarter.User

  plug :scrub_params, "session" when action in [:create]

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password} }) do
    user = Repo.get_by(User, email: email)

    result = cond do
      user && checkpw(password, user.password_hash) ->
        {:ok, login(conn, user)}
      user ->
        {:error, :unauthorized, conn}
      true ->
        dummy_checkpw()
        {:error, :not_found, conn}
    end

    case result do
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
  end

  defp login(conn, user) do
    conn
    |> Guardian.Plug.sign_in(user)
  end
end
