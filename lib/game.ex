defmodule Game do
  defstruct frames: [%Frame{}]

  def roll(pins, game) do
      # Sends a roll_event to each Frame in Game. If additional frames are needed they will be appended.
      # If Game.frames length is greater than 10 the original Game struct is returned.
      # Otherwise a different Game struct with updated frames will be returned.
      new_game = %Game{frames: Enum.map(game.frames, &(Frame.roll_event(pins, &1)))}

      if length(new_game.frames) < 10 && !Frame.is_active?(List.first(new_game.frames)) do
        %Game{new_game | frames: [%Frame{} | new_game.frames] }
      else
        new_game
      end
  end

  def score(game_points) do
    finished_game = List.foldl(game_points, %Game{}, &(Game.roll(&1, &2)))
    #Adds and returns all points from frames.
    Enum.map(finished_game.frames, &(Frame.return_points(&1))) |> Enum.sum
  end
end
