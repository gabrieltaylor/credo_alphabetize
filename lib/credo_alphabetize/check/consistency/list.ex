defmodule CredoAlphabetize.Check.Consistency.List do
  @moduledoc false

  @checkdoc """
  Lists where order doesn't matter should be sorted alphabetically.
  """
  @explanation [check: @checkdoc]

  use Credo.Check, base_priority: :low
  alias Credo.Code

  @doc false
  def run(source_file, params \\ []) do
    excluded_paths = Keyword.get(params, :excluded_paths, [])
    file_names = Keyword.get(params, :file_names, ~s(mix.exs))
    issue_meta = IssueMeta.for(source_file, params)

    cond do
      String.starts_with?(source_file.filename, excluded_paths) ->
        []

      String.ends_with?(source_file.filename, file_names) ->
        Code.prewalk(source_file, &traverse(&1, &2, issue_meta))

      true ->
        []
    end
  end

  defp traverse(
         {_function_type, [line: _line_number, column: _column_number],
          [{:deps, meta, _}, [do: alist]]} = ast,
         issues,
         issue_meta
       )
       when is_list(alist) do
    {ast, issues_for_call(alist, meta, issues, issue_meta)}
  end

  defp traverse(
         {_function_type, [line: _line_number, column: _column_number],
          [{:project, meta, _}, [do: alist]]} = ast,
         issues,
         issue_meta
       )
       when is_list(alist) do
    {ast, issues_for_call(alist, meta, issues, issue_meta)}
  end

  defp traverse(ast, issues, _issue_meta) do
    {ast, issues}
  end

  defp issues_for_call(alist, meta, issues, issue_meta) do
    if alist == Enum.sort(alist) do
      issues
    else
      [issue_for(issue_meta, meta[:line]) | issues]
    end
  end

  defp issue_for(issue_meta, line_no) do
    format_issue(
      issue_meta,
      message: "Consider sorting this list to improve readability.",
      line_no: line_no
    )
  end
end
