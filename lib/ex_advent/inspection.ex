defmodule ExAdvent.Inspection do
  def stringly(t) do
    t
    |> Nx.to_list()
    |> Enum.map(&to_string/1)
    |> Enum.intersperse("\n")
    |> IO.puts()
  end
end
