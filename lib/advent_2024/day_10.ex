defmodule Advent2024.Day10 do
  use ExAdvent.Day, day: 10, input: &ExAdvent.Parsers.tensor/1

  def part_one(input), do: solve(input, MapSet.new())
  def part_two(input), do: solve(input, [])

  def solve(input, collectable) do
    input
    |> findall(0)
    |> Enum.map(&count_paths([&1], input, collectable))
    |> Enum.sum()
  end

  def count_paths(points, t, collectable) do
    points
    |> Enum.flat_map(&take_step(&1, t))
    |> Enum.into(collectable)
    |> Enum.to_list()
    |> case do
      [{_, 9} | _] = xs -> length(xs)
      [_ | _] = xs -> count_paths(xs, t, collectable)
      [] -> 0
    end
  end

  def take_step({{i, j}, k}, t) do
    {i, j}
    |> surrounds(Nx.shape(t))
    |> Enum.map(&{&1, get(t, &1)})
    |> Enum.filter(fn {_p, c} -> c == k + 1 end)
  end

  def findall(t, k) do
    {x, y} = Nx.shape(t)

    for i <- 0..(x - 1),
        j <- 0..(y - 1),
        get(t, {i, j}) == k do
      {{i, j}, k}
    end
  end

  def surrounds({i, j}, {x, y}) do
    Enum.filter(
      [
        {i, j + 1},
        {i, j - 1},
        {i + 1, j},
        {i - 1, j}
      ],
      fn {i, j} -> i in 0..(x - 1) and j in 0..(y - 1) end
    )
  end

  def get(t, {i, j}), do: Nx.to_number(t[i][j])
end
