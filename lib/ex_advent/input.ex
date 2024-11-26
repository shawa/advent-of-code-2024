defmodule ExAdvent.Input do
  @otp_app Application.compile_env(:ex_advent, :otp_app)

  def input_binary_for(day) do
    day
    |> filepath_for()
    |> File.read!()
  end

  def input_lines_for(day) do
    day
    |> input_binary_for()
    |> String.trim()
    |> String.split("\n")
  end

  def input_charlists_for(day) do
    day
    |> input_lines_for()
    |> Enum.map(&String.to_charlist/1)
  end

  def filepath_for(day) do
    Path.join([
      :code.priv_dir(@otp_app),
      "input",
      pad(day),
      "input.txt"
    ])
  end

  defp pad(n) do
    n
    |> Integer.to_string()
    |> String.pad_leading(2, "0")
  end
end
