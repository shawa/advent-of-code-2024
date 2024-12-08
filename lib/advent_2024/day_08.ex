defmodule Advent2024.Day08 do
  use ExAdvent.Day, day: 8, input: &Advent2024.Day08.Parser.parse/1

  import Nx.Defn

  def part_one({tensor, point_map}) do
    point_map
    |> Map.new(fn {frequency, points} ->
      {frequency, pairs(points)}
    end)
    |> Map.new(fn {k, pairs} ->
      {k,
       Enum.flat_map(pairs, fn {p, q} ->
         [
           antinode(p, q),
           antinode(q, p)
         ]
       end)}
    end)
    |> Enum.flat_map(fn {_frequency, antinodes} -> antinodes end)
    |> Enum.into(MapSet.new())
    |> Enum.filter(&in_bounds(&1, tensor))
    |> Enum.count()
  end

  defn antinode(p, q) do
    2 * p - q
  end

  def in_bounds(p, t) do
    {max_x, max_y} = Nx.shape(t)

    Nx.to_number(p[0]) in 0..max_x and
      Nx.to_number(p[1]) in 0..max_y
  end

  def pairs(ts) do
    for p <- ts, q <- ts, p != q, into: MapSet.new() do
      [p, q]
      |> Enum.sort()
      |> List.to_tuple()
    end
  end
end
