defmodule Day5 do
    def load_input(path) do
        {:ok, text} = File.read(path)
        String.split(text, ["\n", "\r", "\r\n"])
      end

    def get_points([{x1, y1}, {x2, y2}]) do
      cond do
        x1 == x2 ->
            Enum.to_list(y1..y2)
            |> Enum.map(fn y -> {x1, y} end)
        y1 == y2 ->
            Enum.to_list(x1..x2)
            |> Enum.map(fn x -> {x, y1} end)
        (x2 > x1) && (y2 > y1) ->
            Enum.to_list(0..x2-x1)
            |> Enum.map(fn x -> {x1+x, y1+x} end)
        (x2 < x1) && (y2 < y1) ->
            Enum.to_list(0..x1-x2)
            |> Enum.map(fn x -> {x1-x, y1-x} end)
        (x2 > x1) && (y2 < y1) ->
            Enum.to_list(0..x2-x1)
            |> Enum.map(fn x -> {x1+x, y1-x} end)
        (x2 < x1) && (y2 > y1) ->
            Enum.to_list(0..x1-x2)
            |> Enum.map(fn x -> {x1-x, y1+x} end)
        true ->
            IO.inspect "oh no"
            [{0,0}, {0,0}]

      end
    end

    defmodule Sheet do
        def create_sheet(x, y) do
            for col <- 0..x, row <- 0..y, into: %{}, do: {{col, row}, "."}
        end

        def add(sheet, point) do
            case Map.get(sheet, point) do
                "." -> Map.put(sheet, point, "1")
                "1" -> Map.put(sheet, point, "2")
                "2" -> Map.put(sheet, point, "2")
                _ -> Map.put(sheet, point, "?")
            end
        end

        def fill(sheet, coords) do
            IO.inspect "fill"
            IO.inspect "sheet before:"
            IO.inspect(Sheet.print(sheet))
            IO.inspect coords
            sheet_new = List.foldr(coords, sheet, fn coord, acc -> Sheet.add(acc, coord) end)
            IO.inspect "sheet after:"
            IO.inspect(Sheet.print(sheet_new))
            IO.inspect "after ok?"
            # IO.inspect sheet
            sheet_new
        end

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
        # input = [
        #     [{0,9}, {5,9}],
        #     [{8,0}, {0,8}],
        #     [{9,4}, {3,4}],
        #     [{2,2}, {2,1}],
        #     [{7,0}, {7,4}],
        #     [{6,4}, {2,0}],
        #     [{0,9}, {2,9}],
        #     [{3,4}, {1,4}],
        #     [{0,0}, {8,8}],
        #     [{5,5}, {8,2}]
        # ]

        input = load_input("./lib/day5/input.txt")
        IO.inspect input
        input = input
        |> Enum.map(& String.split(&1, [",", " -> "]))
        |> Enum.map(fn x -> x |> Enum.map(& String.to_integer(&1)) end)
        |> Enum.map(fn [a,b,c,d] -> [{a,b}, {c,d}] end)
        IO.inspect input

        max_x = input
        |> List.foldr(0, fn [{x1, y1}, {x2, y2}], acc -> cond do x1 > acc -> x1; x2 > acc -> x2; x1 <= acc -> acc; x2 <= acc -> acc end end)
        IO.inspect max_x
        max_y = input
        |> List.foldr(0, fn [{x1, y1}, {x2, y2}], acc -> cond do y1 > acc -> y1; x2 > acc -> y2; y1 <= acc -> acc; y2 <= acc -> acc end end)
        IO.inspect max_y

        sheet = Sheet.create_sheet(max_x, max_y)
        # IO.inspect sheet

        IO.inspect "input:"
        IO.inspect input
        cs = input
        # |> Enum.filter(fn [{x1, y1}, {x2, y2}] -> (x1 == x2) || (y1 == y2) end)
        |> Enum.map(&get_points(&1))
        # |> List.foldr(%{} fn [{x1, y1}, {x2, y2}], acc -> end)
        IO.inspect "CS"
        IO.inspect cs

        sheet_filled = List.foldr(cs, sheet, fn x, acc -> Sheet.fill(acc, x) end)
        IO.inspect sheet_filled

        IO.inspect(Sheet.print(sheet_filled))

        twos = sheet_filled
        |> Enum.to_list()
        |> Enum.count(fn {_, b} -> case b do "2" -> true; _ -> false end end)
        IO.inspect twos
        # twos = for col <- 0..max_x, row <- 0..max_y, into: %{}, do: case Map.get(sheet_filled, {col, row}) do "2" -> 1; _ -> 0 end
        # IO.inspect "twos:"
        # IO.inspect twos

    end
end
