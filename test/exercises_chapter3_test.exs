defmodule ExercisesChapter3Test do
  use ExUnit.Case
  use PropCheck

  property "keysort tuples by index" do
    forall tup_list <- non_empty(list({integer(), integer(), integer()})) do
      size = tuple_size(List.first(tup_list))
      Enum.map(0..(size-1), fn index ->
        is_ordered(index, :lists.keysort(index+1, tup_list))
      end)
      |> Enum.all?(&(&1))      
    end
  end

  def is_ordered(index, [a, b | t]) do
    elem_a = elem(a, index)
    elem_b = elem(b, index)
    elem_a <= elem_b and is_ordered(index, [b | t])
  end

  def is_ordered(_index, _), do: true
end
