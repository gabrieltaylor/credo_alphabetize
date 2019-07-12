defmodule CredoAlphabetize.Check.Consistency.ListTest do
  use Credo.TestHelper

  @described_check CredoAlphabetize.Check.Consistency.List

  #
  # cases NOT raising issues
  #
  test "it should NOT report violations for lists that are not in an included file" do
    """
    defmodule Foo.MixProject do
      defp deps do
        [
          {:b, "~> 1.1"},
          {:a, "~> 1.1"}
        ]
      end
    end
    """
    |> to_source_file("foo.exs")
    |> refute_issues(@described_check)
  end

  test "it should NOT report violation for dependencies that are already alphabetized" do
    """
    defmodule Foo.MixProject do
      defp deps do
        [
          {:a, "~> 1.1"},
          {:b, "~> 1.1"}
        ]
      end
    end
    """
    |> to_source_file("mix.exs")
    |> refute_issues(@described_check)
  end

  test "it should not report a violation for project attributes that are alphabetized" do
    """
    defmodule Foo.MixProject do
      def project do
        [
          app: :ambassador_auth,
          deps: deps(),
          elixir: "~> 1.6",
          preferred_cli_env: [
            coveralls: :test,
            "coveralls.detail": :test,
            "coveralls.post": :test,
            "coveralls.html": :test
          ],
          start_permanent: Mix.env() == :prod,
          test_coverage: [tool: ExCoveralls],
          version: "0.1.0"
        ]
      end
    end
    """
    |> to_source_file("mix.exs")
    |> refute_issues(@described_check)
  end

  #
  # cases raising issues
  #

  test "it should report a violation for dependencies that are not alphabetized" do
    """
    defmodule Foo.MixProject do
      defp deps do
        [
          {:b, "~> 1.1"},
          {:a, "~> 1.1"}
        ]
      end
    end
    """
    |> to_source_file("mix.exs")
    |> assert_issue(@described_check)
  end

  test "it should report a violation for project attributes that are not alphabetized" do
    """
    defmodule Foo.MixProject do
      def project do
        [
          app: :ambassador_auth,
          version: "0.1.0",
          elixir: "~> 1.6",
          start_permanent: Mix.env() == :prod,
          deps: deps(),
          test_coverage: [tool: ExCoveralls],
          preferred_cli_env: [
            coveralls: :test,
            "coveralls.detail": :test,
            "coveralls.post": :test,
            "coveralls.html": :test
          ]
        ]
      end
    end
    """
    |> to_source_file("mix.exs")
    |> assert_issue(@described_check)
  end
end
