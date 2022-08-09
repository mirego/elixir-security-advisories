defmodule ElixirSecurityAdvisories do
  @moduledoc """
  Documentation for `ElixirSecurityAdvisories`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ElixirSecurityAdvisories.hello()
      :world

  """
  def hello do
    Application.get_env(:elixir_security_advisories, :github_access_token)
  end
end
