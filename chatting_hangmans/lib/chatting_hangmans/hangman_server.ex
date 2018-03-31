defmodule ChattingHangmans.HangmanServer do
  alias ChattingHangmans.Hangman
  alias ChattingHangmans.Game

  @name :hangman_server

  use GenServer

  defmodule State do
    defstruct games: %{}, games_queue: %{}
  end

  # Client Interface

  def start_link(_arg) do
    IO.puts("Starting Hangman Game Server ...")
    GenServer.start_link(__MODULE__, %State{}, name: @name)
  end

  def create_new_game(player_name, secret_phrase) do
    GenServer.call(@name, {:create_new_game, player_name, secret_phrase})
  end

  def guess_a_letter(player_name, secret_letter) do
    GenServer.call(@name, {:guess_a_letter, player_name, secret_letter})
  end

  def current_games do
    GenServer.call(@name, :current_games)
  end

  def clear do
    GenServer.cast(@name, :clear)
  end

  # Server Callbacks

  def init(state) do
    {:ok, state}
  end

  def handle_cast(:clear, state) do
    {:noreply, %{state | games: %{}}}
  end

  def handle_call(:current_games, _from, state) do
    {:reply, state.games, state}
  end

  # TODO: Create def create_or_enqueue_game
  def handle_call({:create_new_game, player_name, secret_phrase}, _from, state) do
    current_game = Map.get(state.games, player_name)

    new_game = %Game{players: player_name, secret_phrase: secret_phrase}

    updated_games = Map.put(state.games, player_name, new_game)
    new_state = %{state | games: updated_games}
    {:reply, :created, new_state}
  end

  def handle_call({:guess_a_letter, player_name, letter}, _from, state) do
    current_game = Map.get(state.games, player_name)

    current_game = %Game{current_game | current_letter: letter}

    advanced_current_game = Hangman.play(current_game)

    updated_games = Map.put(state.games, player_name, advanced_current_game)
    new_state = %{state | games: updated_games}
    {:reply, advanced_current_game, new_state}
  end
end

alias ChattingHangmans.HangmanServer
{:ok, pid} = HangmanServer.start_link("anything")

IO.inspect(HangmanServer.create_new_game("larry", "bazinga"))
IO.inspect(HangmanServer.guess_a_letter("larry", "a"))
