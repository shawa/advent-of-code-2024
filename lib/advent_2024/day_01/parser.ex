defmodule Advent2024.Day01.Parser do
  import NimbleParsec
  @type t() :: {[integer()], [integer()]}

  whitespace =
    string(" ")
    |> times(min: 1)

  line =
    integer(min: 1)
    |> ignore(whitespace)
    |> integer(min: 1)
    |> ignore(string("\n"))

  lists =
    line
    |> tag(:row)
    |> times(min: 1)

  defparsec :parse_lists, lists

  @spec parse!(binary) :: t()
  def parse!(input) do
    {:ok, results, "", _context, _line, _column} = parse_lists(input)

    results
    |> Enum.map(fn {:row, [a, b]} -> {a, b} end)
    |> Enum.unzip()
  end
end
