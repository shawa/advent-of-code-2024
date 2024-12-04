defmodule Advent2024.Day04 do
  alias Advent2024.Day04.Parser
  use ExAdvent.Day, day: 4, input: &Parser.parse/1

  def part_one(t) do
    look(t)
    |> Enum.map(&points_between/1)
    |> Enum.map(&extract(t, &1))
    |> Enum.count(&(&1 == "XMAS"))
  end

  def look(t) do
    %{
      "X" => xs,
      "S" => ys
    } = find(t, ["X", "S"])

    for {x1, x2} = x <- xs, {y1, y2} = y <- ys do
      d1 = abs(y1 - x1)
      d2 = abs(y2 - x2)

      keep =
        case {d1, d2} do
          {3, 3} -> true
          {0, 3} -> true
          {3, 0} -> true
          _ -> false
        end

      {keep, {x, y}}
    end
    |> Enum.filter(&elem(&1, 0))
    |> Enum.map(&elem(&1, 1))
  end

  def find(t, needles) do
    {x, y} = Nx.shape(t)

    results =
      for i <- 0..(x - 1), j <- 0..(y - 1), c = t[i][j] |> Nx.to_binary() do
        if c in needles do
          {c, {i, j}}
        else
          nil
        end
      end

    results
    |> Enum.reject(&is_nil/1)
    |> Enum.group_by(&elem(&1, 0), &elem(&1, 1))
  end

  def direction({{x1, x2}, {y1, y2}}) do
    d1 =
      cond do
        y1 == x1 -> 0
        y1 > x1 -> 1
        y1 < x1 -> -1
      end

    d2 =
      cond do
        y2 == x2 -> 0
        y2 > x2 -> 1
        y2 < x2 -> -1
      end

    {d1, d2}
  end

  def points_between({{x1, x2} = x, y}) do
    {d1, d2} = direction({x, y})

    pts =
      [
        x,
        {x1 + d1, x2 + d2},
        {x1 + 2 * d1, x2 + 2 * d2},
        # isn't that ^ neat!!
        ^y = {x1 + 3 * d1, x2 + 3 * d2}
      ]

    pts
  end

  def extract(t, points) do
    point_tensors = points |> Enum.map(&Tuple.to_list/1) |> Nx.tensor()

    t
    |> Nx.gather(point_tensors)
    |> Nx.to_binary()
  end

  def get(t, {x1, x2}), do: t[x1][x2] |> Nx.to_binary()
end
