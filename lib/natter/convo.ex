defmodule Natter.Convo do
  @moduledoc """
  Functions for manipulating a Convo object.

  For creating conversations check out the Natter.Conversation module which
  provides a cosy DSL.
  """

  defstruct module: nil, locals: %{}

  @type t :: %__MODULE__{module: atom,
                         locals: %{optional(atom) => any}}


  @doc """
  Create a new Convo object.

  """
  @spec new(atom) :: t
  def new(convo_module) when is_atom(convo_module) do
    %__MODULE__{module: convo_module}
  end


  @doc """
  Store an item of data on the convo.

      iex> convo = new(MyConvo) |> remember(:name, "Alice")
      iex> convo.locals.name
      "Alice"

  """
  @spec remember(t, atom, any) :: t
  def remember(convo = %__MODULE__{}, key, value) when is_atom(key) do
    locals = Map.put(convo.locals, key, value)
    %{convo | locals: locals}
  end


  @doc """
  Retrieve an item of data previously stored on the convo.

      iex> convo = new(MyConvo)
      iex> recall(convo, :name)
      :error

      iex> convo = new(MyConvo) |> remember(:name, "Mittens")
      iex> recall(convo, :name)
      {:ok, "Mittens"}

  """
  @spec recall(t, atom) :: any
  def recall(%__MODULE__{locals: locals}, key) when is_atom(key) do
    Map.fetch(locals, key)
  end
end

defimpl Inspect, for: Natter.Convo do
  def inspect(convo, _) do
    "#Natter.Convo<#{inspect convo.module}>"
  end
end
