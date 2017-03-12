defmodule PhoenixStarter.Auth do
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  alias PhoenixStarter.User
  alias PhoenixStarter.Repo

  def login_with_email_and_password(conn, email, _password) when is_nil(email) do
    dummy_checkpw()
    {:error, :not_found, conn}
  end

  def login_with_email_and_password(conn, email, password) do
    user = Repo.get_by(User, email: email)

    cond do 
      user && checkpw(password, user.password_hash) ->
        {:ok, login(conn, user)}
      user -> 
        {:error, :unauthorized, conn} 
      true ->
        dummy_checkpw()
        {:error, :not_found, conn}
    end
  end

  def login(conn, user) do
    conn
    |> Guardian.Plug.sign_in(user)
  end

  def logout(conn) do
    Guardian.Plug.sign_out(conn)
  end
end
