# Alien::Libgit2 House Rules

Apply to every task in this repository unless explicitly overridden. Bias: caution over
speed on non-trivial work; use judgment on trivial tasks. Loaded automatically at launch
(same priority as `CLAUDE.md`). Skill content is never restated here: the skills are the
source, and the agents get them force-loaded via `briefing.skills`.

## Engineering discipline

1. **Think before coding** — State assumptions, ask rather than guess, push back when a
   simpler approach exists, stop when confused and name what is unclear.
2. **Simplicity first** — Minimum change that solves the problem, nothing speculative.
3. **Surgical changes** — Touch only what you must; don't improve adjacent code, comments
   or formatting. Match existing style.
4. **Read before you write** — `alienfile` is the whole distribution; read it *and* the CI
   workflows before changing either. They encode the same CMake flags twice on purpose.
5. **Surface conflicts, don't average them** — Pick one pattern (more recent / more
   tested), explain why, flag the other. Don't blend.
6. **Checkpoint after every significant step** — done / verified / left.
7. **Fail loud** — "Done" is wrong if anything was skipped silently; "tests pass" is wrong
   if only one install path ran.

## Delegation

If you can spawn subagents (orchestrating main agent): do NOT touch behavior-relevant files
yourself — delegate. Your lane: coordinate, inspect, plan, review diffs, run tests, write
`Changes` notes and prose docs. Only the `alien-libgit2-*` agents get `alien-libgit2-core` /
`perl-alien` force-loaded via `briefing.skills`; you get no briefing and would edit the
build with too little context. When in doubt, delegate.

| Task | Agent |
|---|---|
| alienfile, share/ tarball, CI workflows, t/, lib/Alien/, POD | `alien-libgit2-worker` (default) |
| Commits, `Changes`, card → done, pre-release audit | `alien-libgit2-release-manager` |

If you ARE an `alien-libgit2-*` agent, the delegation lock does not apply — implement,
refactor, debug and test per these rules.

Behavior-relevant = anything changing what gets installed or how it is found: `alienfile`, `share/`, `.github/workflows/`, `cpanfile`, `dist.ini`, `t/`, and the POD stating the version floor. Prose and `Changes` notes are not.

**Only `alien-libgit2-release-manager` commits.** A worker leaves a commit-ready tree and hands its card to `review`; you then dispatch `alien-libgit2-release-manager` to cut the commit and close the card.

## Project hazards — why this file is worth loading

Mechanism and background: skill `alien-libgit2-core`. These are the locks:

- **Pin the install type in CI.** Without `ALIEN_INSTALL_TYPE` a failed probe falls through to a share build and the job passes as "system". Every job pins `install-type:` — pin it for any job you add.
- **Both install paths, always.** A local `dzil test` proves one path at most. Anything touching the build runs `env ALIEN_INSTALL_TYPE=share dzil test` **and** `env ALIEN_INSTALL_TYPE=system dzil test`.
- **Never lower `minimum_version`.** No Debian release meets the 1.9.3 floor (bookworm
  1.5.1, trixie 1.9.0) — a failing probe there is the designed outcome, not a bug to fix
  by moving the floor.
- **`.claude/` is git-ignored except for a whitelist.** A new directory under it stays
  invisible to git until whitelisted — verify with `git status --short`.
- **Installed skills are build artifacts.** The ones `skilletor` installs are overwritten by
  the next `skilletor sync` — never edit them. Only repo-owned skills (tracked by git, no
  `skilletor` entry) may be edited.

## Coordination — karr board (always in scope)

Ticket coordination is the orchestrating agent's job, so `karr` is always in scope — don't
invoke the `kanban-issues-karr-coordination` skill first, just use it. Git-native kanban;
board state lives in `refs/karr/*` of this repo. Full command surface: that skill.

- `karr list --compact` / `karr board` — open work · `karr show ID` — detail
- `karr create "Title" --priority high --tags a,b --body '…'` — new ticket
- `karr move ID in-progress --claim NAME` — start · `karr handoff ID --claim NAME --note "…"` — to review
- mutating commands auto-sync; `karr sync --pull|--push` for explicit exchange

Work owned by `Git::Libgit2` or `Git::Native` becomes a ticket on that repo's board — never a direct edit there.

**Serialize board mutations when fanning out.** Collect the results, then loop the `karr move`/`handoff`/`sync` calls sequentially — N of them landing at once is a resource event, not a cheap command.

## Release — never without permission

`dzil build` / `dzil test` are fine anytime. `dzil release` and any CPAN upload are STRICTLY forbidden without the maintainer's explicit go-ahead — even if a plan lists "release" as the next step. A libgit2 version change is always its own release, and `Git::Libgit2` / `Git::Native` get told. Pre-release audit goes through `alien-libgit2-release-manager`.

## Public issues (GitHub) — never act without instruction

`karr` is the internal agent board, churned freely. The GitHub issue tracker (`github.com/Getty/p5-alien-libgit2`) carries real people's reports, written under the maintainer's account. Never act on a public issue on your own initiative — not even to read it — unless the user points at a specific item.

## Perl and Alien specifics — reference, don't restate

House Perl style: `getty-perl-core`; Alien::Build mechanics: `perl-alien`; this distribution's own facts: `alien-libgit2-core`. Do not duplicate them here.
