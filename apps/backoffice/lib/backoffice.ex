defmodule MyApp.BackOffice do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use MyApp.BackOffice, :controller
      use MyApp.BackOffice, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def static_paths, do: ~w()

  def controller do
    quote do
      use Phoenix.Controller, namespace: MyApp.BackOffice
      import Plug.Conn
      alias MyApp.BackOffice.Router.Helpers, as: Routes
      import MyApp.BackOffice.Gettext
      import MyApp.Core.Helpers.Pagination
      import MyApp.BackOffice.CacheControl

      alias MyApp.Core.Repo

      import Ecto.Query

      unquote(verified_routes())
    end
  end

  def view(opts \\ []) do
    quote do
      merged_opts =
        [root: "lib/backoffice/templates", namespace: MyApp.BackOffice] ++ unquote(opts)

      use Phoenix.View, merged_opts

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      alias MyApp.BackOffice.Router.Helpers, as: Routes
      import MyApp.BackOffice.ErrorHelpers
      import MyApp.BackOffice.Gettext
      alias MyApp.Core.Helpers.DecimalHelper

      unquote(verified_routes())

      def format(nil), do: nil

      def format(%DateTime{} = d) do
        d |> DateTime.to_naive() |> format
      end

      def format(%NaiveDateTime{} = d) do
        d |> NaiveDateTime.truncate(:second) |> NaiveDateTime.to_string()
      end
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import MyApp.BackOffice.Gettext
    end
  end

  def verified_routes do
    quote do
      use Phoenix.VerifiedRoutes,
        endpoint: MyApp.BackOffice.Endpoint,
        router: MyApp.BackOffice.Router,
        statics: MyApp.BackOffice.static_paths()
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end

  defmacro __using__([which, opts]) when is_atom(which) do
    apply(__MODULE__, which, [opts])
  end
end
