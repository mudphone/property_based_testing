defmodule SetUnionTest do
  use ExUnit.Case
  use PropCheck

  property "set union" do
    forall {set_a, set_b} <- {mapset(number()), mapset(number())} do
      res = MapSet.union(set_a, set_b)

      res == model_union(set_a, set_b)
    end
  end

  def model_union(set_a, set_b) do
    list_a = MapSet.to_list(set_a)
    list_b = MapSet.to_list(set_b)
    MapSet.new(list_a ++ list_b)
  end

  def mapset(mapset_type) do
    let l <- list(mapset_type) do
      MapSet.new(l)
    end
  end
end
