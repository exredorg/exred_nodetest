defmodule Exred.NodeTestTest do
  use ExUnit.Case
  doctest Exred.NodeTest

  use Exred.NodeTest, module: Exred.NodeTest

  test "start_node/0 exists" do
    assert Kernel.function_exported?(__MODULE__, :start_node, 0)
  end

  test "start_node/1 exists" do
    assert Kernel.function_exported?(__MODULE__, :start_node, 1)
  end
end
