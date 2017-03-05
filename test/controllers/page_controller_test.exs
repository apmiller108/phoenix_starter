defmodule PhoenixStarter.PageControllerTest do
  use PhoenixStarter.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "PhoenixStarter"
  end
end
