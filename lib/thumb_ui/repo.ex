defmodule ThumbUi.Repo do
  use Ecto.Repo,
    otp_app: :thumb_ui,
    adapter: Ecto.Adapters.Postgres
end
