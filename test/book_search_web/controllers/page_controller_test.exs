defmodule BookSearchWeb.PageControllerTest do
  use BookSearchWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Jeremy"
  end
end
