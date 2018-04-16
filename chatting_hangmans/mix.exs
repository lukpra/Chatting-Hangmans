defmodule ChattingHangmans.MixProject do
  use Mix.Project

  def project do
    [
      app: :chatting_hangmans,
      description: "Demo App for playing game of hangman on chat",
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ChattingHangmans, []},
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nostrum, git: "https://github.com/Kraigie/nostrum.git"}
    ]
  end
end
