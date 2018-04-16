  defmodule ChattingHangmans.DiscordConsumer do
    use Nostrum.Consumer
  
    alias Nostrum.Api

    require Logger

   alias ChattingHangmans.HangmanServer
  
    def start_link do
        Logger.debug fn ->
            "Starting Discord Consumer ..."
        end
      Consumer.start_link(__MODULE__)
    end
  
    def handle_event({:MESSAGE_CREATE, {msg}, _ws_state}) do

      case msg.content do
        "!hello" ->
            Api.create_message(msg.channel_id, "Yello world bud!")
        "!about" ->
          Api.create_message(msg.channel_id, "So, about msg: #{inspect msg, pretty: true}")
          # This won't stop other events from being handled.
          Process.sleep(3000)
  
        "!ping" ->
          Api.create_message(msg.channel_id, " pong buddy, pong!")
  
        "!raise" ->
          # This won't crash the entire Consumer.
          raise "No problems here!"

        "!mode" ->
          Api.create_message(msg.channel_id, "I am running in:  mode.")

        "!my games" ->
            Api.create_message(msg.channel_id, "Let me check games you have, gimmie a moment ⏳")
            resp = ChattingHangmans.HangmanServer.current_games_for_user(msg.author.id)
            Api.create_message(msg.channel_id, "Hey, #{msg.author.username}, your games are: #{inspect resp, pretty: true}")

        "!start game " <> secret_phrase ->
            Api.create_message(msg.channel_id, "Starting a game for you.")
            resp = ChattingHangmans.HangmanServer.create_new_game(msg.author.id, secret_phrase)
            Api.create_message(msg.channel_id, "Okidoki buddy, done. Or is it? Idk yet i am not that good yet, here: #{inspect resp}")

        "!guess_dbg " <> letter ->
            Api.create_message(msg.channel_id, "So you think letter: #{letter} is right? Let's see ...")
            resp = ChattingHangmans.HangmanServer.guess_a_letter(msg.author.id, letter)
            Api.create_message(msg.channel_id, "So: #{inspect resp, pretty: true}")

        "!guess" <> letter ->
            Api.create_message(msg.channel_id, "So you think letter: #{letter} is right? Let's see ...")
            resp = ChattingHangmans.HangmanServer.guess_a_letter(msg.author.id, letter)
            Api.create_message(msg.channel_id, "#{resp.drawing}")
        
        "good bot" ->
            Api.create_message(msg.channel_id, "K, thx!")
        _ ->
          :ignore
      end
    end
  
    # Default event handler, if you don't include this, your consumer WILL crash if
    # you don't have a method definition for each event type.
    def handle_event(_event) do
      :noop
    end
  end