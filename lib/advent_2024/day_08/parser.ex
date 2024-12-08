defmodule Advent2024.Day08.Parser do
  def parse(input) do
    lines =
      input
      |> String.trim()
      |> String.split()

    point_map =
      lines
      |> Enum.with_index()
      |> Enum.flat_map(fn {line, i} ->
        line
        |> String.to_charlist()
        |> Enum.with_index()
        |> Enum.reject(fn {k, _} -> k == ?. end)
        |> Enum.map(fn {x, j} -> {x, Nx.tensor([i, j])} end)
      end)
      |> Enum.group_by(
        fn {k, _v} -> k end,
        fn {_k, v} -> v end
      )

    tensor =
      lines
      |> Enum.map(&String.to_charlist/1)
      |> Nx.tensor()

    {tensor, point_map}
  end
end
