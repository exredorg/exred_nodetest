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

  test "start_node/2 exists" do
    assert Kernel.function_exported?(__MODULE__, :start_node, 1)
  end

  test "start up the Test Node with custom config" do
    config = %{port: %{value: 1199}}
    ctx = start_node(TestNode, config)
    [pid: pid, node: node] = ctx

    log("CONTEXT: #{inspect(ctx)}")

    assert Process.alive?(pid)

    assert node.config.host.value == "localhost"
    assert node.config.port.value == 1199

    ctx
  end
end
