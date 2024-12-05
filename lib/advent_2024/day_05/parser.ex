defmodule Advent2024.Day05.Parser do
  import NimbleParsec

  @type t() :: {
          Graph.t(),
          [Graph.t()]
        }

  pair =
    integer(min: 1)
    |> ignore(string("|"))
    |> integer(min: 1)
    |> ignore(string("\n"))

  pairs =
    pair
    |> tag(:pair)
    |> times(min: 1)

  line =
    integer(min: 1)
    |> ignore(string(","))
    |> times(min: 1)
    |> integer(min: 1)
    |> ignore(string("\n"))

  lists =
    line
    |> tag(:line)
    |> times(min: 1)

  input =
    tag(pairs, :pairs)
    |> ignore(string("\n"))
    |> tag(lists, :lists)

  defparsec :parse_input, input

  @spec parse(binary()) :: t()
  def parse(input) do
    {:ok, results, "", _context, _line, _column} = parse_input(input)

    [pairs: pairs, lists: lists] = results

    rule_tuples =
      pairs
      |> Keyword.values()
      |> Enum.map(&List.to_tuple/1)

    pages_graphs =
      lists
      |> Keyword.values()
      |> Enum.map(&edges/1)
      |> Enum.map(&graph/1)

    {graph(rule_tuples), pages_graphs}
  end

  defp edges(xs) do
    init = xs |> Enum.reverse() |> tl() |> Enum.reverse()
    Enum.zip(init, tl(xs))
  end

  defp graph(edges) do
    Graph.new()
    |> Graph.add_edges(edges)
  end
end
