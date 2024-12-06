defmodule Advent2024.Day06 do
  alias Advent2024.Day06.Parser

  use ExAdvent.Day, day: 6, input: &Parser.parse/1

  import Nx.Defn

  @ninety_deg_rotation Nx.tensor([[0, 1], [-1, 0]])

  def part_one(state) do
    state
    |> run_simulation()
    |> count_visited()
    |> Nx.to_number()
  end

  defn turn(t), do: Nx.dot(@ninety_deg_rotation, t)
  defn advance(direction, pos), do: direction + pos
  defn mark_visited(board, pos), do: Nx.indexed_put(board, pos, 1)
  defn count_visited(board), do: Nx.sum(board == 1)

  def tick({board, cur_direction, cur_pos}) do
    next_pos = advance(cur_direction, cur_pos)

    case indexed_get(board, next_pos) do
      nil ->
        {:halt, board}

      2 ->
        {:cont, {board, turn(cur_direction), cur_pos}}

      _ ->
        {:cont, {mark_visited(board, next_pos), cur_direction, next_pos}}
    end
  end

  def run_simulation(state) do
    {:cont, {board, _, _}} =
      Stream.iterate({:cont, state}, fn {_action, state} -> tick(state) end)
      |> Stream.take_while(&continue?/1)
      |> Enum.to_list()
      |> List.last()

    board
  end

  defp continue?({:cont, _}), do: true
  defp continue?({:halt, _}), do: false

  def indexed_get(board, location) do
    board |> Nx.gather(location) |> Nx.to_number()
  rescue
    ArgumentError -> nil
  end
end
