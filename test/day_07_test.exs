defmodule Advent2024.Day07Test do
  use ExUnit.Case

  import Advent2024.Day07

  describe "eval/2" do
    test "it isn't bad" do
      cc = &concat/2
      pl = &Kernel.+/2
      ml = &Kernel.*/2

      assert eval([17, cc, 8, pl, 14]) == 192
      assert eval([6, ml, 8, cc, 6, ml, 15]) == 7290
    end
  end
end
