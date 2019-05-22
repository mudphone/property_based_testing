defmodule SetUnionTest do
  use ExUnit.Case
  use PropCheck

  property "set union" do
    forall {list_a, list_b} <- {list(number()), list(number())} do
      set_a = MapSet.new(list_a)
      set_b = MapSet.new(list_b)
      union_list = MapSet.to_list(MapSet.new(list_a ++ list_b))
      model_union = Enum.sort(union_list)

      res =
        MapSet.union(set_a, set_b)
        |> MapSet.to_list()
        |> Enum.sort()

      res == model_union
    end
  end
end
