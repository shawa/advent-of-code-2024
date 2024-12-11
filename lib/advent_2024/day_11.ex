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
    |> Stream.iterate(&iterate/1)
    |> Enum.take(iterations + 1)
    |> Enum.map(fn next ->
      next
      |> Enum.map(fn {_number, count} -> count end)
      |> Enum.sum()
    end)
    |> List.last()
  end

  def iterate(input) do
    input
    |> Enum.flat_map(fn {n, count} ->
      n |> tick() |> Enum.map(&{&1, count})
    end)
    |> Enum.reduce(%{}, fn {k, v}, acc ->
      Map.update(acc, k, v, &(&1 + v))
    end)
  end

  def tick(0), do: [1]

  def tick(n) do
    digits = Integer.to_charlist(n)

    if rem(length(digits), 2) == 0 do
      l_r(digits)
    else
      [n * 2024]
    end
  end

  defp l_r(digits) do
    digits
    |> split()
    |> Tuple.to_list()
    |> Enum.map(&:erlang.list_to_integer/1)
  end

  def split(list) do
    len = round(length(list) / 2)
    Enum.split(list, len)
  end
end
