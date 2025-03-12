defmodule GithubPagesWeb.PortfolioControllerTest do
  use GithubPagesWeb.ConnCase

  describe "show" do
    test "show portfolio", %{conn: conn} do
      conn = get(conn, ~p"/portfolio")
      assert html_response(conn, 200) =~ "This is your portfolio"
    end
  end
end
