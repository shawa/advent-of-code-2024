defmodule Mix.Tasks.ExAdvent.Run do
  use Mix.Task

  def run([]) do
    fetch_modules()
    |> collect_results()
    |> format()
    |> IO.puts()
  end

  defp collect_results(modules) do
    modules
    |> Enum.map(&apply(&1, :run, []))
    |> Enum.with_index(1)
    |> Enum.map(fn {output, i} ->
      {
        i |> inspect(),
        Keyword.get(output, :part_one, "-") |> to_string(),
        Keyword.get(output, :part_two, "-") |> to_string()
      }
    end)
  end

  defp fetch_modules do
    {:ok, all_modules} =
      :application.get_key(:advent_2024, :modules)

    all_modules
    |> Enum.filter(fn module ->
      match?(<<"Elixir.Advent2024.Day", _::binary-size(2)>>, Atom.to_string(module))
    end)
  end

  defp format(entries) do
    header = {
      "Day",
      "Part 1",
      "Part 2"
    }

    rows = [header | entries]

    {m1, m2, m3} =
      rows
      |> Enum.reduce({0, 0, 0}, fn {col1, col2, col3}, {max1, max2, max3} ->
        l1 = String.length(col1)
        l2 = String.length(col2)
        l3 = String.length(col3)

        {
          max(l1, max1),
          max(l2, max2),
          max(l3, max3)
        }
      end)

    [h | t] =
      rows
      |> Enum.map(fn {col1, col2, col3} ->
        [
          IO.ANSI.yellow(),
          String.pad_leading(col1, m1, " "),
          "  ",
          IO.ANSI.green(),
          String.pad_trailing(col2, m2, " "),
          "  ",
          IO.ANSI.red(),
          String.pad_trailing(col3, m3, " "),
          IO.ANSI.reset(),
          "\n"
        ]
      end)

    hrule = 0..(m1 + m2 + m3 + 2) |> Enum.map(fn _ -> "-" end)

    [
      h,
      hrule,
      "\n",
      t
    ]
  end
end
