defmodule Advent2024.Day03.Parser do
  import NimbleParsec

  # literals/

  binary_functor = string("mul")

  unary_functor =
    choice([
      string("don't"),
      string("do")
    ])

  number = integer(min: 1, max: 3)

  binary_args =
    number
    |> ignore(string(","))
    |> concat(number)

  binary_call =
    tag(binary_functor, :functor)
    |> ignore(string("("))
    |> tag(binary_args, :args)
    |> ignore(string(")"))

  unary_call =
    tag(unary_functor, :functor)
    |> ignore(string("()"))

  memory =
    choice([unary_call, binary_call])
    |> tag(:call)
    |> eventually()
    |> times(min: 1)

  defparsec :memory, memory

  @type instruction() ::
          :enable
          | :disable
          | {:mul, integer(), integer()}

  @spec parse(binary()) :: [instruction()]
  def parse(input) do
    {:ok, instructions, _rest, _context, _line, _column} = memory(input)

    instructions
    |> Enum.map(fn
      {:call, [functor: ["don't"]]} ->
        :disable

      {:call, [functor: ["do"]]} ->
        :enable

      {:call, [functor: ["mul"], args: [a, b]]} ->
        {:mul, a, b}
    end)
  end
end

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
