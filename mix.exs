defmodule CredoAlphabetize.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :credo_alphabetize,
      deps: deps(),
      description: "Credo checks to verify alphabetical ordering.",
      docs: [
        extras: ["README.md"],
        main: "readme",
        source_ref: "v#{@version}",
        source_url: "https://github.com/gabrieltaylor/credo_alphabetize"
      ],
      elixir: "~> 1.6",
      homepage_url: "https://github.com/mirego/credo_alphabetize",
      name: "CredoAlphabetize",
      package: package(),
      source_url: "https://github.com/gabrieltaylor/credo_alphabetize",
      start_permanent: false,
      version: @version
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.1"},
      {:dialyxir, "~> 1.0.0-rc.3", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:excoveralls, "~> 0.8", only: :test}
    ]
  end

  defp package do
    %{
      maintainers: ["Gabriel Taylor Russ"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/gabrieltaylor/credo_alphabetize"
      }
    }
  end
end
