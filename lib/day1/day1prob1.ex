defmodule Day1 do
  def run() do
    {:ok, text} = File.read("./lib/day1/input.txt")
    list = String.split(text, ["\n", "\r", "\r\n"])
    list = list |> Enum.map(&String.to_integer/1)

    # problem 1
    accumulator = {hd(list), []}
    output = Enum.map_reduce(tl(list), accumulator, fn x, acc -> {x > elem(acc, 0), {x, [x > elem(acc, 0) | elem(acc, 1)]}} end)
    bool_list = elem(elem(output, 1), 1)
    count = bool_list |> Enum.count(&(&1 == true))
    IO.inspect count

    # problem 2
    chunked_list = list |> Enum.chunk_every(3, 1, :discard)
    sliding_sums = Enum.map(chunked_list, fn x -> Enum.sum(x) end)
    # IO.inspect sliding_sums
    list = sliding_sums

    accumulator = {hd(list), []}
    output = Enum.map_reduce(tl(list), accumulator, fn x, acc -> {x > elem(acc, 0), {x, [x > elem(acc, 0) | elem(acc, 1)]}} end)
    bool_list = elem(elem(output, 1), 1)
    count = bool_list |> Enum.count(&(&1 == true))
    IO.inspect count
  end
end
# a = Day1
# a.run()
