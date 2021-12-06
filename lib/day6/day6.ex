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

  defmodule Ponds do
    def move(fish, {k, v}) do
      case k do
        0 ->
          fish
          |> Map.put(8, v)
          |> Map.put(6, Map.get(fish, 6) + v)
        _ ->
          Map.put(fish, k-1, v)
      end
    end

    def breeding_cycle(fish, n) when n > 0 do
      accumulator = Map.new(Enum.to_list(0..9), fn x -> {x, 0} end)
      # IO.inspect fish
      Map.to_list(fish)
      |> List.foldr(accumulator, fn x, acc -> move(acc, x) end)
      |> breeding_cycle(n-1)
    end

    def breeding_cycle(fish, 0) do
        fish
    end
  end

  def part_two() do
    fish = Map.new(Enum.to_list(0..9), fn x -> {x, 0} end)
    IO.inspect fish

    # input = [3,4,3,1,2] # 26
    input = load_input("./lib/day6/input.txt")

    fish = input
    |> List.foldr(fish, fn x, acc -> Map.put(acc, x, Map.get(acc, x)+1) end)
    IO.inspect fish

    res = Ponds.breeding_cycle(fish, 256)
    IO.inspect res
    count = Map.to_list(res)
    |> List.foldr(0, fn {_, v}, acc -> acc + v end)
    IO.inspect count
  end
end
