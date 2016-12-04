defmodule FoodConversation do
  use Natter.Conversation

  def init(convo) do
    convo
    |> ask("What's your name?", :ask_favourite_food)
  end

  def ask_favourite_food(convo, resp) do
    convo
    |> remember(:name, resp.text)
    |> say("Oh, your name is #{resp.text}")
    |> ask("What's your favourite food?", :summary)
  end

  def summary(convo, resp) do
    {:ok, name} = recall(convo, :name)
    convo
    |> say("Got it, your favourite food is #{resp.text}")
    |> say("""
      Ok, here's what you told me about you:
      - Name: #{name}
      - Favourite Food: #{resp.text}
      """)
    |> finish()
  end
end

defmodule FoodConversation.Test do
  use ExUnit.Case, async: true
  use Natter.Test

  test "a conversation" do
    convo = FoodConversation.new()
    assert {:ok, convo, message} = hear(convo)
    assert message.text == "What's your name?"

    convo = say(convo, "Louis")
    assert {:ok, convo, message} = hear(convo)
    assert message.text == "Oh, your name is Louis"

    assert {:ok, convo, message} = hear(convo)
    assert message.text == "What's your favourite food?"

    convo = say(convo, "Falafal")
    assert {:ok, convo, message} = hear(convo)
    assert message.text == "Got it, your favourite food is Falafal"
    assert {:ok, convo, message} = hear(convo)
    assert message.text == """
    Ok, here's what you told me about you:
    - Name: Louis
    - Favourite Food: Falafal
    """
  end
end
