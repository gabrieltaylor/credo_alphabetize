# CredoAlphabetize

Where order doesn't matter, check that lists are sorted alphabetically.

Sorting makes lists, especially those that are vertical, easier for humans to scan.
So where it makes no difference, consider sorting your lists.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `credo_alphabetize` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:credo_alphabetize, "~> 0.1.0"}
  ]
end
```

Once added to deps, enable the check by including it in the `.credo.exs` checks list like so:

```elixir
%{
  configs: [
    checks: [
      {CredoAlphabetize.Check.Consistency.List},
      ...
    ]
  ]
}
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/credo_alphabetize](https://hexdocs.pm/credo_alphabetize).

## Test

To test a change to this library run:

```
mix test
```
