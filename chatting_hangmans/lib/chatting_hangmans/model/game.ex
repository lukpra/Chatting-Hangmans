defmodule ChattingHangmans.Game do
  @unknown :unknown
  @in_progress :in_progress
  @won :won
  @lost :lost

  defstruct secret_phrase: "",
            guessed_phrase: "",
            current_letter: "",
            players: [],
            letters_guessed_right: [],
            letters_guessed_wrong: [],
            life: 0,
            drawing: "",
            game_state: @unknown

  def unknown, do: @unknown
  def in_progress, do: @in_progress
  def lost, do: @lost
  def won, do: @won
end
