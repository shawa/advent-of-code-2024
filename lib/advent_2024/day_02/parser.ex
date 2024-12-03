defmodule Advent2024.Day02.Parser do
  import NimbleParsec

  @type t() :: [Nx.Tensor.t()]

  whitespace =
    string(" ")
    |> times(min: 1)

  newline =
    string("\n")

  line =
    times(
      integer(min: 1)
      |> ignore(whitespace),
      min: 1
    )
    |> integer(min: 1)
    |> ignore(newline)

  report =
    line
    |> tag(:row)
    |> times(min: 1)

  defparsec :parse_report, report

  @spec parse(binary()) :: t()
  def parse(input) do
    {:ok, results, "", _context, _line, _column} = parse_report(input)

    results
    |> Enum.map(fn {:row, xs} ->
      Nx.tensor(xs)
    end)
  end
end
