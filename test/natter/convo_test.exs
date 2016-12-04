defmodule Natter.ConvoTest do
  use ExUnit.Case, aync: true
  alias Natter.Convo
  doctest Convo, import: true

  test "inspect/1 of a convo" do
    convo = Convo.new(MyConvo)
    assert inspect(convo) == "#Natter.Convo<MyConvo>"
  end
end
