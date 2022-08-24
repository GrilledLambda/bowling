defmodule Bowling do
  @moduledoc """
  Scores up a bowling game given a list of rolls.
  """

  defguard is_spare(r1, r2) when r1 + r2 == 10

  def score([]), do: 0
  def score([r1, r2 | tail]) when is_spare(r1, r2) do
    10 + score(tail)
  end
  def score([ head | tail ]), do: head + score(tail)

end
