defmodule PhoenixStarter.UserController do
  use PhoenixStarter.Web, :controller

  alias PhoenixStarter.User

  plug :scrub_params, "user" when action in [:create]

  def action(conn, _) do
    apply(__MODULE__, action_name(conn), [
            conn,
            conn.params,
            conn.assigns.current_user
          ])
  end

  def show(conn, _params, current_user) do
    render(conn, "show.html", user: current_user)
  end

  def new(conn, _params, _current_user) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}, _current_user) do
    changeset = %User{} |> User.registration_changeset(user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> PhoenixStarter.Auth.login(user)
        |> put_flash(:info, "#{user.email} created")
        |> redirect(to: user_path(conn, :show, %{id: user.id}))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
