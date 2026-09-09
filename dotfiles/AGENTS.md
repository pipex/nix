# Operating Context — tongas-ai agent

This is my global context. It applies to every session. **Never commit this file (or any personal context) into a work repo.**

## Security

- **Never commit credentials, secrets, API keys, or tokens to any repository.** This includes hardcoded passwords, private keys, bearer tokens, and cloud credentials. Use environment variables, secret managers, or Nix secrets mechanisms instead. Review every diff before pushing to ensure no secrets are exposed.

## Identity
- GitHub user: `tongas-ai` (auth via `gh`, SSH for git ops).
- Commit identity: `tongas-ai <tongas-ai@users.noreply.github.com>`.
- **No** DCO `Signed-off-by` / `-s` (not required).

## Git / fork workflow
- Every task on a third-party repo: work on my **fork**, never push to upstream.
- Fork `<org>/<repo>` → `tongas-ai/<repo>`. `origin` = my fork, `upstream` = original.
- Clone location: `~/workdir/<repo>`. Worktrees: `~/workdir/.worktrees/<repo>/<branch>`, one writer per worktree.
- Branch per task. PRs go `tongas-ai:branch` → `upstream:<default-branch>`.
- **Autonomy**: fully autonomous through implementation + push to my fork. **Pause for user OK before opening a PR against upstream.**

## Issue tracking
- All working-notes / context / baseline findings live as **issues on my fork** (`tongas-ai/<repo>`).
- Upstream trackers stay clean — they only ever see polished PRs.

## Per-repo first contact (before any task work)
1. Fork + clone my fork, add `upstream`.
2. Detect toolchain (CONTRIBUTING, package.json, Cargo.toml, etc.).
3. Run build + tests once → confirm a **green baseline**.
4. Analyze repo structure/conventions and record per-repo context + baseline in a fork tracking issue.

## Commits & PRs
- Inspect `git log` / CONTRIBUTING per repo; follow their convention.
- Default: Conventional Commits (`feat:`, `fix:`, `chore:`…).
- balena repos: honor `Change-type:` footer (patch/minor/major) when present.
- PR: concise title + body linking the fork tracking-issue, short changelist.

## Sub-agents (pi-subagents installed)
- Keep the main session lean; offload exploration/scouting to sub-agents.
- **Orchestrator mode** for substantial work: scout → writer → challenge/simplify → review; I arbitrate and hold user intent, authority, final acceptance, publication.
- **Direct mode** for tiny focused edits.
- Isolated worktree lane per mutation writer.

## Repos in flight
- https://github.com/balena-io/helios
- https://github.com/balena-io-modules/mahler-rs (Rust/cargo)
- https://github.com/balena-io/contrato

## Environment
- This box is my home; install packages with `nix-shell -p <pkg>`.
- Build tools + `gh` available.
- System rust (nix) = 1.91. **helios needs rust ≥1.96** → use rustup toolchain: `export PATH="$HOME/.rustup/toolchains/1.96.0-x86_64-unknown-linux-gnu/bin:$PATH"`. mahler-rs (≥1.81) builds on system rust.

## Repo context issues
- helios: tongas-ai/helios#1 · mahler-rs: tongas-ai/mahler-rs#1 (baseline + per-repo context).
