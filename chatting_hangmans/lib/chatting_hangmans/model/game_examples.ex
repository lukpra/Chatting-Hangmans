defmodule ChattingHangmans.GameExamples do
  alias ChattingHangmans.Game

  def bazinga() do
    %Game{secret_phrase: "bazinga", current_letter: "a"}
  end
end
