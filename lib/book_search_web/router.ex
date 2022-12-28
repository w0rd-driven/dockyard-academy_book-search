defmodule BookSearchWeb.Router do
  use BookSearchWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {BookSearchWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Set up a scope for the BookSearchWeb web application
  scope "/", BookSearchWeb do
    # Use the :browser pipeline for all routes within this scope
    pipe_through :browser

    # Define a route for the root path that maps to the index action of the PageController
    get "/", PageController, :index

    # Define routes for the AuthorController actions
    # Index action
    get "/authors", AuthorController, :index
    # New action
    get "/authors/new", AuthorController, :new
    # Show action
    get "/authors/:id", AuthorController, :show
    # Edit action
    get "/authors/edit/:id", AuthorController, :edit
    # Create action
    post "/authors", AuthorController, :create
    # Update action
    put "/authors/:id", AuthorController, :update
    # Update action
    patch "/authors/:id", AuthorController, :update
    # Delete action
    delete "/authors/:id", AuthorController, :delete

    # Define routes for the BookController actions
    # Index action
    get "/books", BookController, :index
    # New action
    get "/books/new", BookController, :new
    # Show action
    get "/books/:id", BookController, :show
    # Edit action
    get "/books/edit/:id", BookController, :edit
    # Create action
    post "/books", BookController, :create
    # Update action
    put "/books/:id", BookController, :update
    # Update action
    patch "/books/:id", BookController, :update
    # Delete action
    delete "/books/:id", BookController, :delete

    # Define routes for the TagController actions
    # Index action
    get "/tags", TagController, :index
    # New action
    get "/tags/new", TagController, :new
    # Create action
    post "/tags", TagController, :create
    # Show action
    get "/tags/:id", TagController, :show
    # Edit action
    get "/tags/:id/edit", TagController, :edit
    # Update action
    put "/tags/:id", TagController, :update
    # Update action
    patch "/tags/:id", TagController, :update
    # Delete action
    delete "/tags/:id", TagController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", BookSearchWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: BookSearchWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
