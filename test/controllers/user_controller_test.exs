defmodule PhoenixStarter.UserControllerTest do
  use    PhoenixStarter.ConnCase
  import Ecto.Query, only: [last: 1]
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

    %{id: id} = User |> last |> Repo.one

    assert html_response(conn, 302) =~ "/profile?id=#{id}"
  end

  test "POST /users with invalid input renders new", %{conn: conn} do
    conn = post conn, "/users", %{user: %{email: "", password: ""}}

    assert html_response(conn, 200) =~ ~r/User\sRegistration/
  end

  test "GET /profile?id= shows the user profile", %{conn: conn} do
    %{id: id, email: email} = insert(:user)
    
    conn = get conn, "/profile?id=#{id}"

    assert html_response(conn, 200) =~ email
  end
end
