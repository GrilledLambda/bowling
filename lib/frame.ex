defmodule Frame do
  @moduledoc"""
    State machine for a frame in a bowling game.
  """

  defstruct points: 0, state: :start, roll: 0, rem: 0
  defguard is_spare(points, roll) when points + roll == 10
  def is_active?(frame), do: frame.state == :open || frame.state == :start
  def return_points(frame), do: frame.points

  # :start states ------------------------------------------------ |
  def roll_event(10, %Frame{state: :start}) do
    %Frame{state: :strike, points: 10, rem: 2}
  end
  def roll_event(roll, %Frame{state: :start}) do
    %Frame{state: :open, points: roll}
  end

  # :open states ------------------------------------------------- |
  def roll_event(roll, %Frame{state: :open, points: points}) when is_spare(points, roll) do
    %Frame{state: :spare, points: points + roll}
  end
  def roll_event(roll, %Frame{state: :open, points: points}) do
    %Frame{state: :done, points: points + roll}
  end

  # :spare states ------------------------------------------------ |
  def roll_event(roll, %Frame{state: :spare, points: points}) do
    %Frame{state: :done, points: points + roll}
  end

  # :stike states ------------------------------------------------ |
  def roll_event(roll, %Frame{state: :strike, points: points, rem: rem}) when rem > 1 do
    %Frame{state: :strike, points: points + roll, rem: 1}
  end
  def roll_event(roll, %Frame{state: :strike, points: points})  do
    %Frame{state: :done, points: points + roll}
  end

  # :done states ------------------------------------------------- |
  def roll_event(_roll, %Frame{state: :done, points: points}), do: %Frame{state: :done, points: points}
end
