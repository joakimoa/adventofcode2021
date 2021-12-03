defmodule Day3 do
  def load_input(path) do
    {:ok, text} = File.read(path)
    list = String.split(text, ["\n", "\r", "\r\n"])
    list |> Enum.map(&String.split(&1))
  end

  def run() do
    input = [
      "00100",
      "11110",
      "10110",
      "10111",
      "10101",
      "01111",
      "00111",
      "11100",
      "10000",
      "11001",
      "00010",
      "01010",]

    data = input |> Enum.map(& String.graphemes(&1))
    IO.inspect data

    # zeroes = List.foldr(data, 0, fn x, acc -> case hd(x) do "0" -> acc + 1; "1" -> acc end end)
    # IO.inspect zeroes

    int_list = Enum.map(data, fn x -> Enum.map(x, fn y -> String.to_integer(y) end) end)
    sum_ones = List.foldr(int_list, {0,0,0,0,0}, fn [aa,bb,cc,dd,ee], {a,b,c,d,e} -> {a+aa, b+bb, c+cc, d+dd, e+ee} end)
    IO.inspect sum_ones
    gamma = Enum.map(Tuple.to_list(sum_ones), fn x -> cond do (x > length(data)/2) -> 1; (x <= length(data)/2) -> 0 end end)
    IO.inspect gamma
    g = Enum.join(gamma)
    {g, _} = IO.inspect Integer.parse(g, 2)

    epsilon = Enum.map(gamma, fn x -> Bitwise.bxor(x,1) end)
    IO.inspect epsilon
    e = Enum.join(epsilon)
    {e, _} = IO.inspect Integer.parse(e, 2)

    p = g * e
    IO.inspect p
  end
end
