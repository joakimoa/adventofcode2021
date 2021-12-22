defmodule Day21 do
  def move(pos, sum_rolls) do
    x = trunc(rem(sum_rolls + pos, 10))
    case x do
      0 -> 10
      _ -> x
    end
  end

  def next_highest(prev_highest) do
    prev_highest + 3
  end

  def roll_sum(highest_roll) do
    (highest_roll - 1) * 3
  end

  def run({pos1, score1}, {pos2, score2}, highest) do
    highest = next_highest(highest)
    sum_rolls = roll_sum(highest)
    # new_spot = f1.(sum_rolls)
    new_spot = move(pos1, sum_rolls)
    score1 = new_spot + score1
    IO.inspect "Player X rolls #{highest-2}+#{highest-1}+#{highest} and moves to space #{new_spot} for a total score of #{score1}."
    cond do
      score1 >= 1000 -> highest * score2
      true -> run({pos2, score2}, {new_spot, score1}, highest)
    end
  end

  def part_one() do
    # Player 1 starting position: 4
    # Player 2 starting position: 8

    # start_4 = &(move(4, &1))
    # start_8 = &(move(8, &1))
    # IO.puts start_4.(1)
    # IO.puts start_4.(10)
    # IO.puts start_4.(11)
    IO.puts run({4, 0}, {8, 0}, 0)
  end
end
