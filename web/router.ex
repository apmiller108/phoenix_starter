defmodule PhoenixStarter.Router do
  use PhoenixStarter.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhoenixStarter do
    pipe_through :browser # Use the default browser stack

    # Session and user routes 
    resources "/users", UserController, only: [:create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    get "/sign_up", UserController, :new
    get "/profile", UserController, :show

    # Static page routes
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixStarter do
  #   pipe_through :api
  # end
end
