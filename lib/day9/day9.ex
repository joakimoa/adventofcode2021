defmodule Day9 do
  def load_input(path) do
    {:ok, text} = File.read(path)
    String.split(text, ["\n", "\r", "\r\n", ","])
    |> Enum.map(& String.split(&1, "|"))
  end


  defmodule Sheet do
    def create_sheet(x, y) do
      for col <- 0..x, row <- 0..y, into: %{}, do: {{col, row}, "."}
    end

    # def add(sheet, point) do
    #   case Map.get(sheet, point) do
    #     "." -> Map.put(sheet, point, "1")
    #     "1" -> Map.put(sheet, point, "2")
    #     "2" -> Map.put(sheet, point, "2")
    #     _ -> Map.put(sheet, point, "?")
    #   end
    # end

    # def fill(sheet, coords) do
    #   IO.inspect "fill"
    #   IO.inspect "sheet before:"
    #   IO.inspect(Sheet.print(sheet))
    #   IO.inspect coords
    #   sheet_new = List.foldr(coords, sheet, fn coord, acc -> Sheet.add(acc, coord) end)
    #   IO.inspect "sheet after:"
    #   IO.inspect(Sheet.print(sheet_new))
    #   IO.inspect "after ok?"
    #   # IO.inspect sheet
    #   sheet_new
    # end

    def print(board) do
      for row <- 0..100 do
        for col <- 0..100 do
          " " <> board[{col, row}]
        end
        |> Enum.join("")
      end
      |> Enum.join("\n")
      |> IO.puts()
    end
  end

  def part_one() do
    input = load_input("./lib/day9/input.txt")
    # IO.inspect input

    input = [
      "2199943210",
      "3987894921",
      "9856789892",
      "8767896789",
      "9899965678"
    ]
    IO.inspect rows = length input
    IO.inspect cols = String.length List.first(input)

    # sheet = input
    # |> List.foldr(%{}, fn x -> List.foldr(x, ))

  end
end
