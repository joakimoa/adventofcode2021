defmodule Day22 do
  def load_input(path) do
      {:ok, text} = File.read(path)
      String.split(text, ["\n", "\r", "\r\n"])
    end

  defmodule Reactor do
    def create_reactor(low, high) do
      for x <- low..high, y <- low..high, z <- low..high, into: %{}, do: {{x,y,z}, :off}
    end

    def get_state(reactor, point) do
      Map.get(reactor, point)
    end

    # :on, :off
    def set_state(reactor, point, state) do
      Map.put(reactor, point, state)
    end

    def set_state_cuboid(reactor, xrange, yrange, zrange, state) do
      delta = for x <- xrange, y <- yrange, z <- zrange, into: %{}, do: {{x,y,z}, state}
      Enum.reduce(delta, reactor, fn {point, state}, acc -> set_state(acc, point, state) end)
    end

    def inspect_cuboid(reactor, xrange, yrange, zrange) do
      # for x <- xrange, y <- yrange, z <- zrange, do: IO.inspect(get_state(reactor, {x,y,z}))
      for x <- xrange, y <- yrange, z <- zrange, do: get_state(reactor, {x,y,z})
    end
  end

  def part_one() do
    # reactor = Reactor.create_reactor(-50, 50)
    # reactor = Reactor.set_state_cuboid(reactor, 0..2, 0..2, 0..2, :on)
    # IO.inspect Enum.count(Reactor.inspect_cuboid(reactor, -1..3, -1..3, -1..3), fn e -> e == :on end)

    reactor = Reactor.create_reactor(-50, 50)
    final_state = load_input("./lib/day22/input.txt")
    |> Enum.map(&String.split(&1, [" x=", ",y=", ",z=", ".."]))
    |> Enum.map(&Enum.map(&1, fn x -> case x do "on" -> :on; "off" -> :off; _ -> String.to_integer(x) end end))
    |> Enum.filter(fn [_, xmin, xmax, ymin, ymax, zmin, zmax] -> xmin >= -50 && ymin >= -50 && zmin >= -50 && xmax <= 50 && ymax <= 50 && zmax <= 50 end)
    |> Enum.map(fn [state, xmin, xmax, ymin, ymax, zmin, zmax] -> [state, xmin..xmax, ymin..ymax, zmin..zmax] end)
    |> Enum.reduce(reactor, fn [state, xrange, yrange, zrange], acc -> Reactor.set_state_cuboid(acc, xrange, yrange, zrange, state) end)
    # IO.inspect final_state

    IO.inspect "Count cubes with state :on"
    IO.inspect Enum.count(Reactor.inspect_cuboid(final_state, -50..50, -50..50, -50..50), fn e -> e == :on end)
  end
end
