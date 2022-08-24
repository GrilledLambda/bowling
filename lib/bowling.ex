defmodule Frame do
  @moduledoc"""
    State machine for a frame in a bowling game.
  """

  defstruct points: 0, state: :start, roll: 0
  defguard is_spare(points, roll) when points + roll == 10

  # :start states
  def roll_event(%Frame{state: :start, roll: roll}) when roll < 10 do
    %Frame{state: :open, points: roll}
  end

  def roll_event(%Frame{state: :start, roll: 10}) do
    %Frame{state: :strike, points: 10}
  end

  # :open states
  def roll_event(%Frame{state: :open, points: points, roll: roll }) when is_spare(points, roll) do
    %Frame{state: :spare, points: points + roll}
  end

  def roll_event(%Frame{state: :open, points: points, roll: roll}) do
    %Frame{state: :done, points: points + roll}
  end

  # :spare states
  def roll_event(%Frame{state: :spare, points: points, roll: roll}) do
    %Frame{state: :done, points: points + roll}
  end

  # :stike states
  def roll_event(%Frame{state: :strike, points: points, roll: roll}) when roll == 10 do
    %Frame{state: :strike, points: points + roll} #this aint gonna work bruh
  end

end
