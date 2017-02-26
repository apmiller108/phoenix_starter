defmodule PhoenixStarter.UserTest do
  use PhoenixStarter.ModelCase
  alias PhoenixStarter.User

  @valid_attrs %{email: "email@example.com", password_hash: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "change set with invalid email address" do
    changeset = User.changeset(%User{}, 
                               %{email: "bad_email", password: "password"})
    refute changeset.valid?
  end

  test "password does not meet minimum requirements" do
    changeset = User.changeset(%User{}, 
                               %{email: "bad_email", password: "abc"})

    refute changeset.valid?
  end
end
