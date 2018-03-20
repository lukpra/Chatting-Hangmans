defmodule ChattingHangmans.GameExamples do
  alias ChattingHangmans.Game

  #   defstruct secret_phrase: "",
  #             guessed_phrase: "",
  #             current_letter: "",
  #             players: %{},
  #             letters_guessed_right: [],
  #             letters_guessed_wrong: [],
  #             life: 0
  def bazinga() do
    %Game{secret_phrase: "bazinga", current_letter: "a"}
  end
end
