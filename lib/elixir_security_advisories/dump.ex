defmodule ElixirSecurityAdvisories.Dump do
  @directory "packages"

  def dump(nodes) do
    nodes
    |> Enum.group_by(& &1["advisory"]["ghsaId"])
    |> Enum.map(&map_vulnerabilities_to_advisories/1)
    |> tap(fn _ -> File.rm_rf!(@directory) end)
    |> Enum.map(&map_advisory_to_file/1)
  end

  defp map_vulnerabilities_to_advisories({_, vulnerabilities = [%{"advisory" => advisory, "package" => package} | _]}) do
    %{
      id: advisory["ghsaId"],
      package: package["name"],
      disclosure_date: advisory_disclosure_date(advisory["publishedAt"]),
      link: advisory["permalink"],
      title: advisory["summary"],
      description: advisory["description"],
      first_patched_versions: Enum.map(vulnerabilities, & &1["firstPatchedVersion"]["identifier"]),
      vulnerable_version_ranges: Enum.map(vulnerabilities, & &1["vulnerableVersionRange"])
    }
  end

  defp advisory_disclosure_date(nil), do: ""

  defp advisory_disclosure_date(published_at) do
    published_at
    |> DateTime.from_iso8601()
    |> case do
      {:ok, date, _} -> to_string(DateTime.to_date(date))
      _ -> ""
    end
  end

  defp map_advisory_to_file(advisory) do
    path = Path.join([@directory, advisory.package, "#{advisory.id}.yml"])
    content = Ymlr.document!(advisory)

    File.mkdir_p!(Path.dirname(path))
    File.write!(path, content)
  end
end
