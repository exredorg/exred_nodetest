defmodule Exred.NodeTest do
  @moduledoc """
  A helper module to set up tests for Exred nodes.

  See example usage below. The `module` argument is the node module that will be tested.

  start_node/0 will start the node. It will add the :pid and :node keys to the test context.
  `:pid` is the process id of the running node GenServer
  `:node` is the node attributes map:

        %{
          module :: atom,
          id :: atom
          name :: string,
          category :: string,
          info :: string,
          config :: map,
          ui_attributes :: map
        }



  ## Example
  (this would go into a test file)

    defmodule Exred.Node.MynodeTest do
      use ExUnit.Case
      use Exred.NodeTest, module: Exred.Node.Mynode

      setup_all do
        Exred.NodeTest.start_node
      end

      test "has pid", context do
        assert is_pid(context.pid)
      end
    end

  """

  defmacro __using__(opts) do
    quote do
      require Logger

      def start_node do
        module = Keyword.get(unquote(opts), :module)

        node_attributes = module.attributes()
        assert is_map(node_attributes)

        node =
          node_attributes
          |> Map.put(:module, module)
          |> Map.put(:id, module)

        if node.category == "daemon" do
          # start child processes
          child_specs = node.module.daemon_child_specs(node.config)
          assert is_list(child_specs)

          log("Starting #{length(child_specs)} child process(es)")

          child_specs
          |> Enum.each(&start_supervised!/1)
        end

        # create a dummy event sending function
        send_event_fun = fn event, payload ->
          log("EVENT: #{inspect(event)} | PAYLOAD: #{inspect(payload)}")
        end

        # start the node
        start_args = [node.id, node.config, send_event_fun]
        child_spec = Supervisor.child_spec({node.module, start_args}, id: node.id)
        pid = start_supervised!(child_spec)

        [pid: pid, node: node]
      end

      def log(msg) do
        Logger.info("TEST OUTPUT: " <> msg)
      end
    end
  end
end
