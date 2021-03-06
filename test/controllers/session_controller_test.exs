defmodule PhoenixStarter.SessionControllerTest do
  use    PhoenixStarter.ConnCase
  import PhoenixStarter.Fixtures

  test "GET /sign_in shows sign in form", %{conn: conn} do
    conn = get conn, "sign_in"

    assert html_response(conn, 200) =~ "Sign in"
  end

  test "POST /sessions logs in user with good credentials", %{conn: conn} do
    insert(:user)
    conn = post(conn, 
                "/sessions", 
                %{session: %{email: "user@example.com", password: "password"}})

    assert html_response(conn, 302) =~ "<a href=\"/\">redirected</a>"
  end

  test "DELETE /sessions logs out user", %{conn: conn} do
    user = insert(:user)

    conn = post(conn, "/sessions/#{user.id}", %{"_method" => "delete"})

    assert html_response(conn, 302) =~ "<a href=\"/\">redirected</a>"
  end
end
