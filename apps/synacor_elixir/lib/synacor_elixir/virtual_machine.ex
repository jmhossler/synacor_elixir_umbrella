defmodule SynacorChallenge.VirtualMachine do
  use GenServer

  @type register :: binary()

  defstruct memory: %{},
            registers: %{
              0 => 0,
              1 => 0,
              2 => 0,
              3 => 0,
              4 => 0,
              5 => 0,
              6 => 0,
              7 => 0
            },
            stack: [],
            position: 0


  @type t :: %__MODULE__{
    memory: map(),
    registers: map(),
    position: integer(),
  }

  def start_link(opts) do
    {program, opts} = Keyword.pop(opts, :program, <<>>)
    GenServer.start_link(__MODULE__, program, opts)
  end

  @spec get_state(atom | pid | {atom, any} | {:via, atom, any}, integer()) :: {:ok, integer()}
  def get_state(ref, index) do
    GenServer.call(ref, {:get_state, index})
  end

  @impl true
  @spec init(binary()) :: {:ok, VirtualMachine.t()}
  def init(input) do
    {:ok, %__MODULE__{memory: input |> parse_binary()}}
  end

  @impl true
  def handle_call({:get_state, index}, _from, state = %__MODULE__{memory: memory}) do
    {:reply, {:ok, memory[index]}, state}
  end

  defp parse_binary(binary) when is_binary(binary) do
    binary
    |> :binary.bin_to_list()
    |> Enum.chunk_every(2)
    |> Enum.map(&:binary.list_to_bin/1)
    |> Enum.map(& :binary.decode_unsigned(&1, :little))
    |> Enum.with_index()
    |> Enum.map(fn {k,v} -> {v,k} end)
    |> Map.new()
  end
end
