defmodule Advent2024.Day03 do
  alias Advent2024.Day03.Parser
  use ExAdvent.Day, day: 3, input: &Parser.parse/1

  def part_one(instructions) do
    instructions
    |> Enum.reduce(0, fn
      {:mul, a, b}, n ->
        n + a * b

      _instruction, n ->
        n
    end)
  end

  def part_two(instructions) do
    instructions
    |> Enum.reduce({:enabled, 0}, fn
      :enable, {_, n} ->
        {:enabled, n}

      :disable, {_, n} ->
        {:disabled, n}

      {:mul, _, _}, {:disabled, _n} = acc ->
        acc

      {:mul, a, b}, {:enabled, n} ->
        {:enabled, n + a * b}
    end)
    |> elem(1)
  end
end
