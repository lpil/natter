defmodule Natter.QueueTest do
  use ExUnit.Case, aync: true
  alias Natter.Queue
  doctest Queue, import: true

  test "inspect/1 of a convo" do
    queue = Queue.new([1, 2, 3])
    assert inspect(queue) == "#Natter.Queue<[1, 2, 3]>"
  end
end
