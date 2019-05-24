defmodule CountWordsTest do
  use ExUnit.Case
  use PropCheck

  property "count words" do
    forall list_of_lists <- non_empty(list(non_empty(list(range(32, 126))))) do
      space_matcher = ~r/\s+/

      clean_word = fn char_list ->
        s = to_string(char_list)
        Regex.replace(space_matcher, s, "")
      end

      words =
        list_of_lists
        |> Enum.map(clean_word)
        |> Enum.reject(&(&1 == ""))

      num_words = length(words)
      sentence = Enum.join(words, " ")
      num_words == length(String.split(sentence, space_matcher))
    end
  end
end
