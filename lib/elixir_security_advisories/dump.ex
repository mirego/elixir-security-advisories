defmodule ElixirSecurityAdvisories.Dump do
  def dump(nodes) do
    File.rm_rf!("packages")

    nodes
    |> Enum.group_by(& &1["advisory"]["ghsaId"])
    |> Enum.map(fn {_, vulnerabilities} ->
      [vulnerability | _] = vulnerabilities
      advisory = vulnerability["advisory"]

      %{
        id: advisory["ghsaId"],
        package: vulnerability["package"]["name"],
        disclosure_date: advisory["publishedAt"],
        cve: advisory["ghsaId"],
        link: advisory["permalink"],
        title: advisory["summary"],
        description: advisory["description"],
        first_patched_versions: Enum.map(vulnerabilities, & &1["firstPatchedVersion"]["identifier"]),
        vulnerable_version_ranges: Enum.map(vulnerabilities, & &1["vulnerableVersionRange"])
      }
    end)
    |> Enum.map(fn advisory ->
      path = Path.join(["packages", advisory.package, "#{advisory.id}.yml"])
      content = Ymlr.document!(advisory)

      File.mkdir_p!(Path.dirname(path))
      File.write!(path, content)
    end)
  end
end
