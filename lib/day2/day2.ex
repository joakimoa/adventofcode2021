defmodule Day2 do
  def load_input(path) do
    {:ok, text} = File.read(path)
    list = String.split(text, ["\n", "\r", "\r\n"])
    list |> Enum.map(&String.split(&1))
  end

  def part_one(input) do
    h_pos = Enum.filter(input, fn [a,_] -> a == "forward" end)
    |> List.foldr(0, fn [_,b], acc -> acc + String.to_integer(b) end)

    ups = Enum.filter(input, fn [a,_] -> a == "up" end)
      |> List.foldr(0, fn [_,b], acc -> acc + String.to_integer(b) end)

    downs = Enum.filter(input, fn [a,_] -> a == "down" end)
      |> List.foldr(0, fn [_,b], acc -> acc + String.to_integer(b) end)

    depth = downs - ups
    h_pos * depth
  end

  defmodule Sub do
    def navigate([c, v], {h_pos, aim, depth}) do
      case c do
      "up" ->
        IO.inspect {h_pos, aim - v, depth}
      "down" ->
        IO.inspect {h_pos, aim + v, depth}
      "forward" ->
        IO.inspect {h_pos + v, aim, depth + (aim * v)}
      end
    end
  end

  def part_two(input) do
    # test
    # list = [["forward", "5"],["down", "5"],["forward", "8"],["up", "3"],["down", "8"],["forward", "2"]]

    # accumulator = {0, 0, 0} # h_pos, aim, depth
    input = Enum.map(input, fn [a,b] -> [a,String.to_integer(b)] end)
    {h_pos, aim, depth} = List.foldl(input, {0,0,0}, fn x, acc -> Sub.navigate(x, acc) end)
    IO.inspect {h_pos, aim, depth}
    IO.inspect h_pos * depth
  end

  def run() do
    list = load_input("./lib/day2/input.txt")
    IO.inspect part_one(list)
    IO.inspect part_two(list)
  end
end
