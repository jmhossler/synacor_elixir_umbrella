defmodule SynacorChallengeWeb.PageController do
  use SynacorChallengeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
