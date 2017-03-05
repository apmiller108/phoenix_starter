defmodule PhoenixStarter.UserControllerTest do
  use    PhoenixStarter.ConnCase
  import PhoenixStarter.Auth
  import PhoenixStarter.Fixtures

  alias PhoenixStarter.User

  test "GET /user/new", %{conn: conn} do
    conn = get conn, "/sign_up"

    assert html_response(conn, 200)
  end

  test "POST /users with valid input redirects to show", %{conn: conn} do
    conn = post conn, "/users", %{
      user: %{
        email: "user@example.com", 
        password: "password" 
      }
    }

    assert html_response(conn, 302) =~ "/profile" 
  end

  test "POST /users with invalid input renders new", %{conn: conn} do
    conn = post conn, "/users", %{user: %{email: "", password: ""}}

    assert html_response(conn, 200) =~ ~r/User\sRegistration/
  end

  test "GET /profile shows the user profile", %{conn: conn} do
    user = insert(:user)

    conn = 
      conn
      |> guardian_login(user)
      |> get("/profile")

    assert html_response(conn, 200) =~ user.email
  end

  test "GET /profile for unathenticated users", %{conn: conn} do
    conn = get conn, "/profile"

    assert html_response(conn, 302) =~ "/sign_in"
  end
end
