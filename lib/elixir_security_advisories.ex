defmodule ElixirSecurityAdvisories do
  defdelegate dump(nodes), to: ElixirSecurityAdvisories.Dump
end
