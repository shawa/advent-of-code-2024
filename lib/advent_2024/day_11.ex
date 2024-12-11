defmodule Advent2024.Day11 do
  use ExAdvent.Day, day: 11, input: &parse/1

  def parse(binary) do
    binary
    |> String.trim()
    |> String.split()
    |> Enum.map(&:erlang.binary_to_integer/1)
  end

  def part_one(input), do: stones(input, 25)
  def part_two(input), do: stones(input, 75)

  def stones(input, iterations) do
    input
    |> Enum.frequencies()
    |> iterate(&blink/1, iterations)
    |> Enum.reduce(0, fn {_number, count}, acc -> count + acc end)
  end

  def iterate(input, _fun, 0), do: input
  def iterate(input, fun, n), do: iterate(fun.(input), fun, n - 1)

  def blink(input) do
    input
    |> Enum.flat_map(fn {n, count} ->
      Enum.map(new_stone(n), &{&1, count})
    end)
    |> Enum.reduce(%{}, fn {k, v}, acc ->
      Map.update(acc, k, v, &(&1 + v))
    end)
  end

  def new_stone(0), do: [1]

  def new_stone(n) do
    digits = Integer.to_charlist(n)
    len = length(digits)

    if rem(len, 2) == 0 do
      digits
      |> Enum.split(round(len / 2))
      |> Tuple.to_list()
      |> Enum.map(&:erlang.list_to_integer/1)
    else
      [n * 2024]
    end
  end
end
