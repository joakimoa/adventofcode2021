defmodule Day7 do
  def load_input(path) do
    {:ok, text} = File.read(path)
    String.split(text, ["\n", "\r", "\r\n", ","])
    |> Enum.map(& String.to_integer(&1))
  end

  def part_one() do
    input = load_input("./lib/day7/input.txt")
    # input = [16,1,2,0,4,2,7,1,2,14]

    IO.inspect "size"
    size = IO.inspect length(input)

    input = Enum.sort(input)
    list_t = List.to_tuple(input)
    median = cond do
      rem(size, 2) != 0 -> elem(list_t, trunc((size / 2) - 0.5))
      rem(size, 2) == 0 -> (elem(list_t, trunc(size / 2) - 1) + elem(list_t, trunc(size / 2))) / 2
    end
    IO.inspect "median: "
    IO.inspect median
    median = trunc(median)

    fuel_cost = input
    |> List.foldr(0, fn x, acc -> cond do (median - x) >= 0 -> acc + (median - x); true -> acc + (x - median) end end)
    IO.inspect "fuel_cost"
    IO.inspect fuel_cost
  end
end
