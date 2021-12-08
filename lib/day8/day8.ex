defmodule Day8 do
  def load_input(path) do
    {:ok, text} = File.read(path)
    String.split(text, ["\n", "\r", "\r\n", ","])
    |> Enum.map(& String.split(&1, "|"))
  end

  def part_one() do
    input = load_input("./lib/day8/input.txt")
    IO.inspect input
    out_vals = input
    |> Enum.map(fn [_, b] -> String.split(b, " ") end)
    IO.inspect out_vals

    out_vals = List.flatten(out_vals)
    IO.inspect out_vals

    known = out_vals
    |> Enum.filter(fn "" -> false; _ -> true end)
    |> Enum.filter(fn x -> case String.length(x) do 2 -> true; 3 -> true; 4 -> true; 7 -> true; _ -> false end end)

    IO.inspect length known
  end
end
