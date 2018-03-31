defmodule ChattingHangmans.Game do
  defstruct secret_phrase: "",
            guessed_phrase: "",
            current_letter: "",
            players: [],
            letters_guessed_right: [],
            letters_guessed_wrong: [],
            life: 0,
            drawing: ""
end
