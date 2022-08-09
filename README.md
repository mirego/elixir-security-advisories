# Elixir Security Advisories

[![](https://github.com/mirego/elixir-security-advisories/actions/workflows/cd.yml/badge.svg)](https://github.com/mirego/elixir-security-advisories/actions/workflows/cd.yml)

This repository is a dump of all Elixir/Erlang security advisories inside [GitHub Advisory Database](https://github.com/advisories).

This repository intends to be used as a replacement for [dependabot/elixir-security-advisories](https://github.com/dependabot/elixir-security-advisories) since it is no longer maintained, as of July 2022.

The _actual reason_ we (Mirego) need a public GitHub repository of Elixir security advisories, is because of [MixAudit](https://github.com/mirego/mix_audit), the tool we built to make sure our Elixir projects are scanned for potential vulnerabilities. MixAudit needs to be ran anonymously and locally (or in continuous integration) by anyone, so it cannot use GitHub GraphQL API’s [`securityVulnerabilities` query](https://docs.github.com/en/graphql/reference/queries#securityvulnerabilities) since it requires authentication.

This is why, every 6 hours, through [this workflow](https://github.com/mirego/elixir-security-advisories/blob/master/.github/workflows/cd.yml), the `packages` directory is synced with GitHub Advisory Database 🎉
