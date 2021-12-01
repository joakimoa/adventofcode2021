text = File.read("input.txt")
text = elem(text, 1)
list = String.split(text, ["\n", "\r", "\r\n"])
list = list |> Enum.map(&String.to_integer/1)

accumulator = {hd(list), []}
output = Enum.map_reduce(tl(list), accumulator, fn x, acc -> {x > elem(acc, 0), {x, [x > elem(acc, 0) | elem(acc, 1)]}} end)
bool_list = elem(elem(output, 1), 1)
count = bool_list |> Enum.count(&(&1 == true))
IO.inspect count
