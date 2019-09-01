defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view

  def turn(left, target) when target >= left do
    "opacity: 1"
  end

  def turn(left, _target) do
    "opacity: 0.1"
  end
  
  def new_game_button(conn) do
    button("New Game", to: hangman_path(conn, :create_game))
  end

  def game_over?(%{ game_state: game_state }) do
    game_state in [ :won, :lost ]
  end
  
  @responses %{
    :won  =>         { :success, "You won!" },
    :lost =>         { :danger, "You lost!" },
    :good_guess =>   { :success, "Good guess!" },
    :bad_guess =>    { :warning, "Bad guess!" },
    :already_used => { :info, "You already guessed that letter." },
  }

  def game_state(state) do
    @responses[state]
    |> alert()
  end

  defp alert(nil) do
    ""
  end

  defp alert({class, message}) do
    """
    <div class="alert alert-#{class}">
    #{message}
    </div>
    """
    |> raw()
  end
end
