# defmodule Mix.Tasks.ExAdvent.New do
#   use Mix.Task

#   def run([day]) do
#     n = day |> :erlang.binary_to_integer(day) |> pad()

#     filename = "day_#{n}"

#     module =
#       {:"Elixir.Advent2024.Day#{n}",
#        Path.join([
#          "lib",
#          "advent_2024",
#          "#{filename}.ex"
#        ])}

#     File.mkdir_p!(
#       Path.join([
#         "lib",
#         "advent_2024",
#         "#{filename}"
#       ])
#     )

#     parser =
#       {Module.concat(module, Parser),
#        Path.join([
#          "lib",
#          "advent_2024",
#          "#{filename}",
#          "parser.ex"
#        ])}
#   end

#   defp module_contents(n, n_str, parser) do
#     quote do
#       defmodule unquote(:"Elixir.Advent2024.Day#{n_str}") do
#         use ExAdvent.Day, day: unquote(n), input: &unquote(parser).parse/1
#       end
#     end
#   end

#   defp pad(n) do
#     n
#     |> Integer.to_string()
#     |> String.pad_leading(2, "0")
#   end
# end
