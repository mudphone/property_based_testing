defmodule KeysortTest do
  use ExUnit.Case
  use PropCheck

  property "keysort tuples by index" do
    forall tup_list <- non_empty(list(non_empty_tuple())) do
      min_size =
        tup_list
        |> Enum.map(&tuple_size/1)
        |> Enum.min()

      Enum.map(0..(min_size - 1), fn index ->
        is_ordered(index, :lists.keysort(index + 1, tup_list))
      end)
      |> Enum.all?()
    end
  end

  def non_empty_tuple() do
    such_that(tup <- tuple(), when: tuple_size(tup) != 0)
  end

  def is_ordered(index, [a, b | t]) do
    elem_a = elem(a, index)
    elem_b = elem(b, index)
    elem_a <= elem_b and is_ordered(index, [b | t])
  end

  def is_ordered(_index, _), do: true
end
