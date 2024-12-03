defmodule Advent2024.Day01 do
  alias Advent2024.Day01.Parser
  use ExAdvent.Day, day: 1, input: &Parser.parse!/1

  @spec part_one(Parser.t()) :: integer()
  def part_one({left, right}) do
    Enum.zip_with(
      Enum.sort(left),
      Enum.sort(right),
      &abs(&2 - &1)
    )
    |> Enum.sum()
  end

  @spec part_two(Parser.t()) :: integer()
  def part_two({left, right}) do
    freqs = Enum.frequencies(right)

    left
    |> Enum.map(&(&1 * Map.get(freqs, &1, 0)))
    |> Enum.sum()
  end
end
