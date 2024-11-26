defmodule ExAdvent.Day do
  defmacro __using__(opts) do
    day = Keyword.fetch!(opts, :day)
    input_format = Keyword.fetch!(opts, :input)

    try do
      input =
        case input_format do
          :lines -> ExAdvent.Input.input_lines_for(day)
          :charlists -> ExAdvent.Input.input_charlists_for(day)
          :binary -> ExAdvent.Input.input_binary_for(day)
        end

      quote do
        def input do
          unquote(input)
        end

        def run() do
          mfas =
            [
              {__MODULE__, :part_one, 1},
              {__MODULE__, :part_two, 1}
            ]

          mfas
          |> Enum.filter(fn {module, function, arity} ->
            function_exported?(module, function, arity)
          end)
          |> Enum.map(fn {module, function, _arity} ->
            {function, apply(module, function, [input()])}
          end)
        end
      end
    rescue
      File.Error ->
        reraise(
          "No input found in `priv/input` for given day." <>
            " " <>
            "I expected to find `#{ExAdvent.Input.filepath_for(day)}`, but nothing was there!",
          __STACKTRACE__
        )
    end
  end
end
