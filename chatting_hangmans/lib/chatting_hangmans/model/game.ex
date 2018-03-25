defmodule ChattingHangmans.Game do
  defstruct secret_phrase: "",
            guessed_phrase: "",
            current_letter: "",
            players: %{},
            letters_guessed_right: [],
            letters_guessed_wrong: [],
            life: 0,
            drawing: ""

  #   def determin_game_state({} = game) do
  #     if is_game_lost(game) do
  #       :lost
  #     else
  #       if is_game_won(game) do
  #         :won
  #       else
  #         :in_progress
  #       end
  #     end
  #   end

  #   def is_game_won(%Game{} = game),
  #     do: game.secret_phrase == game.guessed_phrased and not is_game_lost(game)
  # end

  # def is_game_lost(%Game{} = game) do
  #   life <= 0
  # end
end
