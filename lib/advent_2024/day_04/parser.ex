defmodule Advent2024.Day04.Parser do
  def parse(input) do
    input
    |> String.split()
    |> Enum.map(&to_charlist/1)
    |> Nx.tensor(names: [:x, :y], type: :u8)
  end
end
