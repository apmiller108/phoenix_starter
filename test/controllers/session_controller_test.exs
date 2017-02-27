defmodule PhoenixStarter.SessionControllerTest do
  use    PhoenixStarter.ConnCase
  import PhoenixStarter.Fixtures

  alias PhoenixStarter.User

  test "GET /sign_in shows sign in form", %{conn: conn} do
    conn = get conn, "sign_in"

    assert html_response(conn, 200) =~ "Sign in"
  end

  test "POST /sessions logs in user with good credentials", %{conn: conn} do
    insert(:user)
    conn = post(conn, 
                "/sessions", 
                %{session: %{email: "user@example.com", password: "password"}})
    # TODO: finish create action and test

  end
end
