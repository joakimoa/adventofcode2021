defmodule Day3 do
  def load_input(path) do
    {:ok, text} = File.read(path)
    String.split(text, ["\n", "\r", "\r\n"])
  end

  def run() do
    # input = [
    #   "00100",
    #   "11110",
    #   "10110",
    #   "10111",
    #   "10101",
    #   "01111",
    #   "00111",
    #   "11100",
    #   "10000",
    #   "11001",
    #   "00010",
    #   "01010",]
    input = load_input("./lib/day3/input.txt")

    data = input |> Enum.map(& String.graphemes(&1))
    IO.inspect data

    int_list = Enum.map(data, fn x -> Enum.map(x, fn y -> String.to_integer(y) end) end)
    sum_ones = List.foldr(int_list, {0,0,0,0,0,0,0,0,0,0,0,0}, fn [aa,bb,cc,dd,ee,ff,gg,hh,ii,jj,kk,ll], {a,b,c,d,e,f,g,h,i,j,k,l} -> {a+aa, b+bb, c+cc, d+dd, e+ee, f+ff, g+gg, h+hh, i+ii, j+jj, k+kk, l+ll} end)
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
