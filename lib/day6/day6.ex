defmodule Day6 do
  def load_input(path) do
    {:ok, text} = File.read(path)
    String.split(text, ["\n", "\r", "\r\n", ","])
    |> Enum.map(& String.to_integer(&1))
  end

  defmodule Lanternfish do
    def breeding_cycle(fish, n) when n > 0 do
      new = fish
      |> Enum.filter(fn x -> x == 0 end)
      |> Enum.map(fn _ -> 9 end)
      # IO.inspect new, charlists: :as_lists

      fish = fish ++ new
      |> Enum.map(fn x -> x - 1 end)
      |> Enum.map(fn x -> cond do x == -1 -> 6; true -> x end end)
      breeding_cycle(fish, n-1)
    end

    def breeding_cycle(fish, 0) do
      fish
    end
  end

  def part_one() do
    # input = [3,4,3,1,2]
    input = load_input("./lib/day6/input.txt")
    IO.inspect input

    #append new 9's for each 0 found
    #decrease all with 1
    #map all -1's to 6

    input = Lanternfish.breeding_cycle(input, 80)
    IO.inspect input, charlists: :as_lists
    IO.inspect Enum.count(input)
  end
end
