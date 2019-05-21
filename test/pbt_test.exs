defmodule PbtTest do
  use ExUnit.Case
  use PropCheck
  doctest Pbt

  property "always works" do
    forall type <- term() do
      boolean(type)
    end
  end

  def boolean(_) do
    true
  end

  property "finds biggest element" do
    forall x <- non_empty(list(integer())) do
      biggest(x) == List.last(Enum.sort(x))
    end
  end

  property "finds biggest element p35" do
    forall x <- non_empty(list(integer())) do
      Pbt.biggest(x) == model_biggest(x)
    end
  end

  def model_biggest(list) do
    List.last(Enum.sort(list))
  end
  
  def biggest([head | tail]) do
    biggest(tail, head)
  end

  defp biggest([], max) do
    max
  end

  defp biggest([head | tail], max) when head >= max do
    biggest(tail, head)
  end

  defp biggest([head | tail], max) when head < max do
    biggest(tail, max)
  end

  # Limit the number of tests:
  # property "exercise 2: a sample", [{:numtests, 10}] do
  # property "exercise 2: a sample", [10] do
  property "exercise 2: a sample" do
    forall {start, count} <- {integer(), non_neg_integer()} do
      list = Enum.to_list(start..(start + count))
      count + 1 == length(list) and increments(list)
    end
  end

  def increments([head | tail]), do: increments(head, tail)

  defp increments(_, []), do: true

  defp increments(n, [head | tail]) when head == n + 1 do
    increments(head, tail)
  end

  defp increments(_, _), do: false
end
