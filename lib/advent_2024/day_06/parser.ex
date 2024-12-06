defmodule Advent2024.Day06.Parser do
  def parse(input) do
    board =
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(fn line ->
        line
        |> to_charlist()
        |> Enum.map(fn
          ?. -> 0
          ?^ -> 1
          ?# -> 2
        end)
      end)
      |> Nx.tensor()

    {
      board,
      # start off going north
      Nx.tensor([-1, 0]),
      find_coord(board, 1)
    }
  end

  def find_coord(t, needle) do
    {x, y} = Nx.shape(t)

    [pos] =
      for i <- 0..(x - 1),
          j <- 0..(y - 1),
          pos = Nx.tensor([i, j]),
          cell = t |> Nx.gather(pos) |> Nx.to_number(),
          cell == needle do
        pos
      end

    pos
  end
end
