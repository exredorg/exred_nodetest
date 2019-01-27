defmodule Exred.NodeTestTest do
  use ExUnit.Case
  doctest Exred.NodeTest

  use Exred.NodeTest, module: Exred.NodeTest

  test "start_node/0 exists" do
    funs = __info__(:functions)

    assert Keyword.fetch(funs, :start_node) == {:ok, 0}
  end
end
