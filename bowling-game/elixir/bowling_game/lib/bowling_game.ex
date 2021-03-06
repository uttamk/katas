defmodule BowlingGame do
  @spec start()::pid
  def start() do
    {:ok, pid} = GenServer.start(BowlingGameServer, [])
    pid
  end

  @spec roll(pid, integer)::list
  def roll(game_pid, pins) do
    GenServer.call(game_pid, {:roll, pins})
  end

  @spec score(pid)::integer
  def score(game_pid) do
    GenServer.call(game_pid, {:score})
  end
end

defmodule BowlingGameServer do
  use GenServer

  def init(_args) do
    {:ok, BowlingGame.Game.init()}
  end

  def handle_call({:roll, pins}, _from, state) do
    state = BowlingGame.Game.roll(state, pins)
    {:reply, state, state}
  end

  def handle_call({:score}, _from, state) do
    score = BowlingGame.Game.score(state)
    {:reply, score, state}
  end
end
