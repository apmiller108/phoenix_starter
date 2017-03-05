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

  pipeline :login_required do
    plug Guardian.Plug.EnsureAuthenticated, 
         handler: PhoenixStarter.GuardianErrorHandler
  end

  scope "/", PhoenixStarter do
    pipe_through [:browser, :with_session]

    # Static page routes
    get "/", PageController, :index

    # Session and user routes 
    resources "/users", UserController, only: [:create]
    resources "/sessions", SessionController, only: [:create, :delete]
    get "/sign_in", SessionController, :new
    get "/sign_up", UserController, :new

    # Registered user routes
    scope "/" do
      pipe_through [:login_required]
      get "/profile", UserController, :show
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixStarter do
  #   pipe_through :api
  # end
end
