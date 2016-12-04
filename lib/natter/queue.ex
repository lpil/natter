defmodule Natter.Queue do
  @moduledoc false

  defstruct q: :queue.new()
  @type t :: :queue.queue

  @doc """
  Construct a new queue from the given list.

      iex> new() |> inspect()
      "#Natter.Queue<[]>"

      iex> [1, 2] |> new() |> inspect()
      "#Natter.Queue<[1, 2]>"
  """
  @spec new([any]) :: t
  def new(xs \\ []) when is_list(xs) do
    %__MODULE__{q: :queue.from_list(xs)}
  end


  @doc """
  Enqueue an item.

      iex> q = new() |> enqueue(:hello)
      iex> dequeue(q)
      {:value, :hello, new()}
  """
  @spec enqueue(t, any) :: t
  def enqueue(%{q: q}, x) do
    %__MODULE__{q: :queue.in(x, q)}
  end


  @doc """
  Dequeue the next item from the queue.

      iex> q = new() |> enqueue(:hello)
      iex> dequeue(q)
      {:value, :hello, new()}

      iex> q = new()
      iex> dequeue(q)
      :empty
  """
  @spec dequeue(t) :: {:value, any, t} | :empty
  def dequeue(%{q: q}) do
    case :queue.out(q) do
      {{:value, value}, q} -> {:value, value, %__MODULE__{q: q}}
      _ -> :empty
    end
  end


  @doc """
  Peek at the next item without removing it.

      iex> q = new() |> enqueue(:hello)
      iex> peek(q)
      {:value, :hello}

      iex> q = new()
      iex> peek(q)
      :empty
  """
  @spec peek(t) :: {:value, any} | :empty
  def peek(%{q: q}) do
    :queue.peek(q)
  end
end

defimpl Inspect, for: Natter.Queue do
  def inspect(%{q: q}, _) do
    "#Natter.Queue<#{inspect :queue.to_list(q)}>"
  end
end
