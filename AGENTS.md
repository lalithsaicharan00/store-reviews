# For every AI agent working in this repository

**Read [`RULEBOOK.md`](RULEBOOK.md) in full before changing anything.** It holds every rule for this repository:
speed (S), data safety (D), design and behaviour (U), testing (T) and how we work (W). The user calls it **the
Rulebook**; each rule exists because a mistake was made once. Quote rule numbers when you explain a choice, and add
to the Rulebook the same day you learn something new.

Then follow [`CLAUDE.md`](CLAUDE.md) for where things are in the repository.

## CI coordination — every agent, every provider

Read **Rulebook T10 before every push or test dispatch**. Ordinary documentation and work-in-progress pushes use
commit messages without CI/performance/widget tags; the skipped iOS job does not interfere with active tests.
Add test tags only when intentionally testing. Before a tagged push, workflow dispatch or rerun, check live Actions
status across the repository: wait for other agents' queued/running tests to complete, then check again before
starting your own. Never cancel their tests. Avoid the widget cancellation tag unless the user explicitly authorizes
it and no other agent's work can be cancelled. Do this without waiting for a reminder from the user.

Keep the full policy in [`RULEBOOK.md`](RULEBOOK.md), not a separate competing rule set. Recent feedback and current
status belong in [`Current Work Checklist`](<iOS/Docs/Checklists/Current Work Checklist.md>); preserve its item numbers
when integrating documentation from branches that still use the former Next Up filename.
