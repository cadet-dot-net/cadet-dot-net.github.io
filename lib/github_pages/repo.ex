defmodule GithubPages.Repo do
  use Ecto.Repo,
    otp_app: :github_pages,
    adapter: Ecto.Adapters.Postgres
end
