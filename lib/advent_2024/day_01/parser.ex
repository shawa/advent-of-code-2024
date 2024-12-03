defmodule Advent2024.Day01.Parser do
  import NimbleParsec
  @type t() :: {[integer()], [integer()]}

  whitespace =
    ascii_char([32..32])
    |> times(min: 1)

  line =
    integer(min: 1)
    |> ignore(whitespace)
    |> integer(min: 1)
    |> ignore(ascii_char([?\n..?\n]))
    |> tag(:row)

  lists = times(line, min: 1)
  defparsec :lists, lists

  @spec parse!(binary) :: t()
  def parse!(input) do
    {:ok, results, "", _, _, _} = lists(input)

    results
    |> Enum.map(fn {:row, [a, b]} -> {a, b} end)
    |> Enum.unzip()
  end
end
