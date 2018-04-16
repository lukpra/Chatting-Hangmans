defmodule ChattingHangmans do

  use Application

  def start(_type, _args) do
    IO.puts("Starting application ... 🏁 ")
    ChattingHangmans.Supervisor.start_link()
  end
end
