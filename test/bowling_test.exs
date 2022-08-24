defmodule BowlingTest do
  use ExUnit.Case, async: true
  doctest Bowling

  test "no special scores" do
    assert Bowling.score([1,2,3,4]) == 10
  end

  test "when a spare is scored" do
    assert Bowling.score([3, 7, 5, 0]) == 15
  end

  test "when a strike is scored" do
    assert Bowling.score([10, 5, 4]) == 28
  end

  test "sibiling scores equal 10 but aren't in the same frame" do
    assert Bowling.score([3, 3, 7, 2]) == 15
  end

  test "a strike precedes a spare" do
    assert Bowling.score([10, 3, 7, 5, 0]) == 40
  end

  test "when a perfect game is bowled" do
    assert Bowling.score([10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]) == 300
  end

end
