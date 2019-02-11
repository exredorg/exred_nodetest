ExUnit.start()

defmodule TestNode do
  @name "DummyNode"
  @category "dummy"
  @info "this does not do anything"
  @config %{
    host: %{type: "string", value: "localhost", attrs: %{max: 50}},
    port: %{type: "number", value: 1200, attrs: %{min: 0, max: 65535}}
  }
  @ui_attributes %{}

  use Exred.NodePrototype
  require Logger
end
