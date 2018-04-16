defmodule ChattingHangmans.Supervisor do
    use Supervisor
  
    def start_link do
      IO.puts "Starting master supervisor..."
      Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
    end
  
    def init(:ok) do
      children = [
        ChattingHangmans.HangmanServer,
        ChattingHangmans.DiscordConsumer 
      ]
  
      Supervisor.init(children, strategy: :one_for_one)
    end
  end
  