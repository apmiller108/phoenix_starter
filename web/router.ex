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

  pipeline :with_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
    plug PhoenixStarter.CurrentUser
  end

  scope "/", PhoenixStarter do
    pipe_through [:browser, :with_session]

    # Session and user routes 
    resources "/users", UserController, only: [:create]
    resources "/sessions", SessionController, only: [:create, :delete]
    get "/sign_in", SessionController, :new
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
