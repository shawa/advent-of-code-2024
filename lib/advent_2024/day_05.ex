defmodule Advent2024.Day05 do
  alias Advent2024.Day05.Parser
  use ExAdvent.Day, day: 5, input: &Parser.parse/1

  def part_one({ordering, updates}) do
    updates
    |> Enum.filter(&Graph.is_subgraph?(&1, ordering))
    |> Enum.map(&middle(Graph.topsort(&1)))
    |> Enum.sum()
  end

  def part_two({ordering, updates}) do
    updates
    |> Enum.reject(&Graph.is_subgraph?(&1, ordering))
    |> Enum.map(fn g ->
      g
      |> Graph.vertices()
      |> then(&Graph.subgraph(ordering, &1))
      |> Graph.topsort()
      |> middle()
    end)
    |> Enum.sum()
  end

  defp middle(list), do: Enum.at(list, floor(length(list) / 2))
end
