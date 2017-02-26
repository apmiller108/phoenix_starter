defmodule PhoenixStarter.Fixtures do
  alias PhoenixStarter.User
  alias PhoenixStarter.Repo

  def attrs(:user) do
    %{email: "user@example.com", password: "password"}
  end

  def build(:user) do
    %User{}
    |> Map.merge(attrs(:user))
  end

  def insert(:user) do
    Repo.insert! build(:user)
  end
end

