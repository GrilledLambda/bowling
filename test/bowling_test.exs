defmodule GameTest do
  use ExUnit.Case, async: true
  doctest Game

  test "no special scores",                                     do: assert Game.score([1,2,3,4]) == 10

  test "when a spare is scored",                                do: assert Game.score([3, 7, 5, 0]) == 20

  test "when a strike is scored",                               do: assert Game.score([10, 5, 4]) == 28

  test "sibiling scores equal 10 but aren't in the same frame", do: assert Game.score([3, 3, 7, 2]) == 15

  test "a strike precedes a spare",                             do: assert Game.score([10, 3, 7, 5, 0]) == 40

  test "when a perfect game is bowled",                         do: assert Game.score([10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]) == 300

  test "when a game with extra frames are scored",              do: assert Game.score([10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]) == 300
end
