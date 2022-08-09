defmodule ElixirSecurityAdvisories.Dump do
  def dump(nodes) do
    nodes
    |> Enum.group_by(& &1["advisory"]["ghsaId"])
    |> Enum.map(fn {_, vulnerabilities} ->
      [vulnerability | _] = vulnerabilities
      advisory = vulnerability["advisory"]

      disclosure_date =
        advisory["publishedAt"]
        |> case do
          nil ->
            ""

          date ->
            {:ok, disclosure_date, _} = DateTime.from_iso8601(date)
            to_string(DateTime.to_date(disclosure_date))
        end

      %{
        id: advisory["ghsaId"],
        package: vulnerability["package"]["name"],
        disclosure_date: disclosure_date,
        cve: advisory["ghsaId"],
        link: advisory["permalink"],
        title: advisory["summary"],
        description: advisory["description"],
        first_patched_versions: Enum.map(vulnerabilities, & &1["firstPatchedVersion"]["identifier"]),
        vulnerable_version_ranges: Enum.map(vulnerabilities, & &1["vulnerableVersionRange"])
      }
    end)
    |> tap(fn _ -> File.rm_rf!("packages") end)
    |> Enum.map(fn advisory ->
      path = Path.join(["packages", advisory.package, "#{advisory.id}.yml"])
      content = Ymlr.document!(advisory)

      File.mkdir_p!(Path.dirname(path))
      File.write!(path, content)
    end)
  end
end
