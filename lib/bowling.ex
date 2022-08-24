defmodule Frame do
  defstruct points: 0, state: :start, roll: 0

  def roll_event(%Frame{state: :start, roll: roll}) when roll < 10 do
    %Frame{state: :done, points: roll}
  end

  def roll_event(%Frame{state: :start, roll: 10}) do
    %Frame{state: :done, points: 10}
  end

end

defmodule Game do
  defguard not_done(frame) when frame.state != :done

  def score_frame(frame, _) when frame.state == :done, do: frame.points
  def score_frame(frame, []), do: frame.points
  def score_frame(frame, next_frames) when not_done(frame) do
    generate_frame(frame, next_frames)
  end


  def generate_frame(frame, [head | tail]) when not_done(frame) do
    frame = %{frame | roll: head}
    new_frame = Frame.roll_event(frame)
    score_frame(new_frame, tail)
  end

  def do_stuff(frames) do
    generate_frame(%Frame{}, frames)
  end
end

new_game = Game
IO.inspect(new_game.do_stuff([1,2,3,4,5])) #should == 10
