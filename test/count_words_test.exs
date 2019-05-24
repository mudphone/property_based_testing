defmodule CountWordsTest do
  use ExUnit.Case
  use PropCheck

  property "count words" do
    forall list_of_words <- non_empty(list(utf8_word())) do
      space_matcher = ~r/\s+/

      words =
        list_of_words
        |> Enum.reject(&(&1 == ""))

      num_words_model = length(words)

      sentence = Enum.join(words, " ")

      word_count =
        sentence
        |> String.split(space_matcher)
        |> Enum.reject(&(&1 == ""))
        |> length()

      word_count == num_words_model
    end
  end

  def utf8_word() do
    let s <- PropCheck.BasicTypes.utf8() do
      Regex.replace(~r/\W+/, s, "")
    end
  end
end
