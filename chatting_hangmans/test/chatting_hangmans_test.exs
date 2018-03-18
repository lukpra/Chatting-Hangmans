defmodule ChattingHangmansTest do
  use ExUnit.Case
  doctest ChattingHangmans

  test "greets the world" do
    assert ChattingHangmans.hello() == :world
  end
end
