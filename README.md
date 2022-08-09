<div align="center">
  <img src="https://user-images.githubusercontent.com/11348/183662131-4213af19-2d9e-4895-bf4b-fea05fae11c3.png" width="1191" />
  <br /><br />
  <a href="https://github.com/mirego/elixir-security-advisories/actions/workflows/ci.yml"><img src="https://github.com/mirego/elixir-security-advisories/actions/workflows/ci.yml/badge.svg?branch=master&event=push" /></a>
  <a href="https://github.com/mirego/elixir-security-advisories/actions/workflows/cd.yml"><img src="https://github.com/mirego/elixir-security-advisories/actions/workflows/cd.yml/badge.svg" /></a><br /><br />
</div>

This repository is a dump of all Elixir/Erlang security advisories inside [GitHub Advisory Database](https://github.com/advisories).

This repository intends to be used as a replacement for [dependabot/elixir-security-advisories](https://github.com/dependabot/elixir-security-advisories) since it is no longer maintained, as of July 2022.

The _actual reason_ we (Mirego) need a public GitHub repository of Elixir security advisories, is because of [MixAudit](https://github.com/mirego/mix_audit), the tool we built to make sure our Elixir projects are scanned for potential vulnerabilities. MixAudit needs to be ran anonymously and locally (or in continuous integration) by anyone, so it cannot use GitHub GraphQL API’s [`securityVulnerabilities` query](https://docs.github.com/en/graphql/reference/queries#securityvulnerabilities) since it requires authentication.

This is why, every 6 hours, through [this workflow](https://github.com/mirego/elixir-security-advisories/blob/master/.github/workflows/cd.yml), the `packages` directory is synced with GitHub Advisory Database 🎉

## License

`elixir-security-advisories` is © 2022 [Mirego](https://www.mirego.com) and may be freely distributed under the [New BSD license](http://opensource.org/licenses/BSD-3-Clause). See the [`LICENSE.md`](https://github.com/mirego/elixir-security-advisories/blob/master/LICENSE.md) file.

However, since the data inside the `packages` directory is pulled from GitHub API, it is licensed under the under the terms of the CC-BY 4.0 open source license. See [GitHub documentation](https://docs.github.com/en/site-policy/github-terms/github-terms-for-additional-products-and-features#advisory-database) for the full terms.

The shield logo is based on [this lovely icon by Saeful Muslim](https://thenounproject.com/icon/shield-1258213/), from The Noun Project. Used under a [Creative Commons BY 3.0](http://creativecommons.org/licenses/by/3.0/) license.
