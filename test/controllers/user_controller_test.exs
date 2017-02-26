defmodule PhoenixStarter.UserControllerTest do
  use    PhoenixStarter.ConnCase
  import Ecto.Query, only: [last: 1]

  alias PhoenixStarter.User

  test "GET /user/new", %{conn: conn} do
    conn = get conn, "/sign_up"
    assert html_response(conn, 200)
  end

  test "POST /users", %{conn: conn} do
    conn = post conn, "/users", %{user: %{email: "user@example.com", password: "password" }}

    %{id: id} = User |> last |> Repo.one

    assert html_response(conn, 302) =~ "/profile?id=#{id}"
  end
end
