if Version.match?(System.version(), ">= 1.15.0-dev") do
  # workaround for https://github.com/alco/mix-erlang-tasks and others
  # see https://github.com/elixir-lang/elixir/issues/12601
  Code.compiler_options(on_undefined_variable: :warn)
end

defmodule MyApp.Umbrella.Mixfile do
  use Mix.Project

  def project do
    [
      version: version(Mix.env()),
      apps_path: "apps",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      lockfile: lockfile()
    ]
  end

  def version(_), do: "0.1.0"

  defp deps do
    []
  end

  defp lockfile do
    "mix.lock"
  end

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
