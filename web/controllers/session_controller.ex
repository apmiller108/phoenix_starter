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
  end

  def delete(conn, _) do
  end
end
