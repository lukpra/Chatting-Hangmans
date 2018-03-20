defmodule ChattingHangmans.Hangman do
  @moduledoc """
  Handles Hangman gameplay
  """
  @lifes_number 8

  alias ChattingHangmans.Game

  @doc "Transforms current game state into new one"
  def play(game) do
    game
    |> parse
    |> validate_input
    |> initialize_new_game
    |> advance_game
    |> draw_game
  end

  def parse(%Game{secret_phrase: secret_phrase, current_letter: current_letter} = game) do
    %{
      game
      | secret_phrase: String.trim(secret_phrase),
        current_letter: String.trim(current_letter)
    }
  end

  def validate_input(%Game{current_letter: ""} = _game) do
    raise "Current letter cannot be empty!"
  end

  def validate_input(%Game{current_letter: current_letter} = game) do
    if String.length(current_letter) > 1 do
      raise "You can only guess one character at a time, no cheating!"
    else
      game
    end
  end

  def validate_input(%Game{} = game) do
    if game.current_letter in game.letters_guessed_right or
         game.current_letter in game.letters_guessed_wrong do
      raise "You have already guessed this letter"
    else
      game
    end
  end

  def initialize_new_game(%Game{guessed_phrase: ""} = game) do
    secret_size = String.length(game.secret_phrase)

    # fix me
    %Game{game | guessed_phrase: encode_secret(secret_size), life: @lifes_number}
  end

  # There is no need to initialize
  def initialize_new_game(%Game{} = game) do
    game
  end

  def advance_game(%Game{} = game) do
    matching_letters =
      game.secret_phrase
      |> String.to_charlist()
      |> Enum.with_index()
      |> Enum.filter(fn {letter, index} ->
        letter == List.first(to_charlist(game.current_letter))
      end)
      |> Enum.into(%{}, fn {letter, index} -> {index, letter} end)

    IO.inspect(game.secret_phrase |> String.to_charlist())
    IO.inspect(matching_letters)

    process_guessed_letters(game, matching_letters)
  end

  # Case when guessed letter was wrong
  def process_guessed_letters(%Game{} = game, matching_letters)
      when map_size(matching_letters) == 0 do
    %Game{
      game
      | letters_guessed_wrong: [game.current_letter | game.letters_guessed_wrong],
        life: game.life - 1
    }
  end

  # Case when guessed letter was right
  def process_guessed_letters(%Game{} = game, matching_letters) do
    %Game{
      game
      | guessed_phrase: encode_secret(game.guessed_phrase, matching_letters),
        letters_guessed_right: [game.current_letter | game.letters_guessed_right]
    }
  end

  def encode_secret(encoded_phrase, matching_letters)
      when is_map(matching_letters) do
    encoded_phrase
    |> String.to_charlist()
    |> Enum.to_list()
    |> Enum.with_index()
    |> Enum.map(fn {letter, index} -> Map.get(matching_letters, index, letter) end)
    |> to_string
  end

  def encode_secret(encoded_phrase, []) do
    encoded_phrase
  end

  def encode_secret(number_of_letters) when is_integer(number_of_letters) do
    String.duplicate("_", number_of_letters)
  end

  def draw_game(%Game{} = game) do
    game
  end
end
