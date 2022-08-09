defmodule ElixirSecurityAdvisories.Repo do
  use Tesla

  plug(Tesla.Middleware.BaseUrl, "https://api.github.com")

  plug(Tesla.Middleware.Headers, [
    {"authorization", "bearer #{Application.get_env(:elixir_security_advisories, :github_access_token)}"},
    {"user-agent", "https://github.com/mirego/elixir-security-advisories"}
  ])

  plug(Tesla.Middleware.JSON)

  @body """
  query($after: String) {
    securityVulnerabilities(first: 10, ecosystem: ERLANG, after: $after) {
      pageInfo {
        endCursor
      }
      totalCount
      nodes {
        vulnerableVersionRange
        firstPatchedVersion {
          identifier
        }
        package {
          name
        }
        advisory {
          description
          ghsaId
          permalink
          summary
          publishedAt
        }
      }
    }
  }
  """

  def all(nodes \\ [], after_cursor \\ nil) do
    post("/graphql", %{query: @body, variables: %{after: after_cursor}})
    |> case do
      {:ok,
       %Tesla.Env{
         status: 200,
         body: %{
           "data" => %{
             "securityVulnerabilities" => %{
               "nodes" => new_nodes,
               "pageInfo" => %{"endCursor" => end_cursor}
             }
           }
         }
       }}
      when not is_nil(end_cursor) ->
        all(nodes ++ new_nodes, end_cursor)

      _ ->
        nodes
    end
  end
end
