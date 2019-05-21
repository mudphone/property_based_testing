defmodule Pbt do
  @moduledoc """
  Documentation for Pbt.
  """

  @doc """
  Return the biggest member of a list.

  ## Examples

      iex> Pbt.biggest([1,2,3,2])
      3

  """
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
end
