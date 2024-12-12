defmodule ExAdvent.Parsers do
  @spec tensor(binary()) :: Nx.tensor()
  def tensor(input) do
    input
    |> String.trim()
    |> String.split()
    |> Enum.map(&to_charlist/1)
    |> Nx.tensor()
    |> Nx.subtract(?0)
  end
end
