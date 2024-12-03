defmodule Advent2024.Day03.Parser do
  import NimbleParsec

  binary_functor =
    string("mul")

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

  defparsec :parse_memory, memory

  @type instruction() ::
          :enable
          | :disable
          | {:mul, integer(), integer()}

  @spec parse(binary()) :: [instruction()]
  def parse(input) do
    {:ok, instructions, _rest, _context, _line, _column} = parse_memory(input)

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
