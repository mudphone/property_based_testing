defmodule CountWordsTest do
  use ExUnit.Case
  use PropCheck

  property "count words" do
    forall list_of_lists <- non_empty(list(non_empty_ascii())) do
      space_matcher = ~r/\s+/

      words =
        list_of_lists
        |> Enum.map(&to_string/1)
        |> Enum.reject(& &1 == "")

      num_words = length(words)
      sentence = Enum.join(words, " ")
      num_words == length(String.split(sentence, space_matcher))
    end
  end

  def non_blank_ascii(), do: range(33, 126)
  
  def non_empty_ascii() do
    let a <- non_empty(list(non_blank_ascii())), do: a
  end

end
