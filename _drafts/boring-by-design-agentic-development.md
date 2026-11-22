---
title: "Boring by Design: Why Agentic Software Development Needs Less Magic"
subtitle: "How explicit contracts, predictable stacks, and executable checks keep AI-assisted codebases maintainable"
description: "Why stable standards, small dependency surfaces, explicit contracts, and executable feedback make AI-assisted software engineering more reliable."
category: [ "Editorials" ]
tags: [ "AI", "Software Engineering", "Agents", "Architecture", "Web Standards" ]
seoimage: 3026/001.jpg
---

{% include image.html
url="/static/postimages/3026/001.jpg"
alt="Editorial illustration contrasting dark floating black-box modules and tangled gears on the left with grounded modular architecture, explicit conduits, verification gauges, and an engineer inspecting a clear system diagram on the right"
%}

*The most agent-friendly technology is not necessarily the newest, smallest, or most popular. It is the technology whose behavior we can explain, verify, and maintain.*

An October 2026 [Codemotion article by Matteo Antony Mistretta](https://www.codemotion.com/magazine/ai-ml/why-ai-hates-modern-web-frameworks-and-loves-web-standards/) asks why AI coding assistants seem comfortable with HTML, CSS, and straightforward JavaScript but can struggle with the invisible machinery of modern reactive frameworks. Its examples are familiar: Vue's reactivity can be disrupted by destructuring, React effects have dependency rules, and reactive updates can depend on state changes spread across multiple files.

That observation is useful, but I think the more important conclusion goes beyond frontend development.

**The advantage of boring technology in agentic development is not that language models inherently love standards or hate frameworks. It is that explicit, stable, inspectable systems leave fewer opportunities for an agent to make a plausible but wrong assumption.**

This matters for browser interfaces, but also for backend services, CLIs, build pipelines, deployment workflows, and infrastructure code. If an agent is going to modify a system repeatedly, the architecture must make incorrect assumptions visible before they turn into production behavior.

## Vibe coding and agent-assisted engineering are different things

As I argued when writing about [why refusing AI misses the point]({% post_url 2026-11-22-on-refusing-AI-and-missing-the-point %}), blind delegation ("vibe coding") works for disposable prototypes, not for systems that have to survive real users and ongoing maintenance. Agent-assisted engineering requires the opposite: an explicit architecture and verification loop where wrong assumptions are cheap to detect and correct.

## Every abstraction spends an uncertainty budget

Abstractions are not inherently bad. We create them to remove repetitive work, establish conventions, and hide irrelevant detail. But some abstractions hide details that become relevant when something breaks.

Consider two ways to implement a feature. In the first, an event handler reads explicit input, calls a function, and updates a visible result. In the second, the same behavior crosses a reactive store, an injected service, a generated route, a plugin, and a framework lifecycle callback. Both may be valid. But the second requires the agent to reconstruct more relationships before it can confidently modify the feature.

This is the strongest insight from the Codemotion discussion: **the cost of an abstraction is partly the context required to use it correctly**. That cost is not measured only in lines of code or tokens. It includes undocumented conventions, cross-file relationships, configuration defaults, and behavior that appears only at runtime.

Research on long-context models supports caution here. In [*Lost in the Middle*](https://aclanthology.org/2024.tacl-1.9/), researchers found that models could use information less reliably depending on its position in a long prompt. The study was not a benchmark of web frameworks, so it does not prove that Angular or React is harder for agents. It does show why a larger context window is not a substitute for selecting and exposing the relevant information.

A small but mysterious codebase may be worse than a larger, well-structured one. What matters is the amount of *unresolved* context, not raw size.

## Standards reduce the number of competing truths

HTML, CSS, HTTP, JavaScript, and established language standard libraries have a practical advantage: their contracts are documented independently of any one application or vendor. The web platform also has a mature compatibility reference in [MDN Baseline](https://developer.mozilla.org/en-US/docs/Glossary/Baseline/Compatibility).

If a browser-native form, URL API, `fetch()` call, or CSS layout solves the problem, an additional package needs to justify its existence. Without it, there is one less release schedule, API dialect, compatibility matrix, and transitive dependency graph to keep in sync.

That does **not** mean every native API is simple, universally supported, or secure by default. Native browser APIs have their own subtleties; compatibility, accessibility, and security still need testing. Nor does it mean avoiding libraries that solve genuinely hard problems.

The rule I find useful is: **prefer a stable platform capability first; adopt an abstraction when it removes more complexity than it introduces.**

That rule also applies outside the web. A CLI that can use ordinary files, standard process exit codes, and a stable command-line interface may be easier to operate and automate than one that requires a separate orchestration layer. A service that communicates over documented HTTP and JSON contracts is easier to integrate than one whose behavior depends on unpublished framework conventions.

The contract is what makes the software understandable across tools, teams, and agents.

## The dangerous hallucination is often a convincing API

A coding agent does not need to invent an obviously impossible function to create a serious bug. It can produce code that *looks* completely natural but targets another version of a library, assumes a configuration default that changed, or imports a package that does not exist.

That last failure has been measured. The USENIX Security 2025 paper [*We Have a Package for You!*](https://www.usenix.org/conference/usenixsecurity25/presentation/spracklen) examined 576,000 generated code samples across 16 models. In its tested settings, the researchers reported hallucinated-package rates of at least 5.2% for commercial models and 21.7% for open-source models. These figures describe that study, not the probability that any particular 2026 agent will invent a package. But they establish a real software supply-chain failure mode: a fake dependency name can even become an attack target.

The risk is amplified when an agent is allowed to run package-install commands without review.

A small dependency surface helps, but package count alone is a poor metric. One maintained, mainstream framework can be safer than six obscure micro-libraries. A widely deployed framework also provides documentation, conventions, static analysis, and examples that an agent may already know well.

The goal is to minimize **unverified dependencies and version-specific assumptions**, not to chase zero dependencies at any cost.

For JavaScript projects, a committed lockfile and reproducible installation with [`npm ci`](https://docs.npmjs.com/cli/v11/commands/npm-ci/) are a useful baseline. Similar principles apply in other ecosystems: pin what you execute, inspect changes to dependency manifests, prefer supported releases, and make dependency additions an explicit decision.

## Mainstream can be more predictable than minimalist

Here is the counterargument that an anti-framework position often misses: **familiarity is itself a form of reliability**.

React, Vue, Angular, and other mature frameworks are not merely bundles of magic. They are also well-documented ecosystems with predictable project structures, established tooling, migration guidance, and huge bodies of example code. An agent may make fewer mistakes in a conventional React repository than in a custom "lightweight" framework created last weekend.

Sometimes the framework's own guidance even favors removing unnecessary abstraction. React's documentation explicitly recommends avoiding effects when no external synchronization is needed: [*You Might Not Need an Effect*](https://react.dev/learn/you-might-not-need-an-effect).

So I would not choose vanilla JavaScript for a complex application solely because an AI will help build it. I would choose the **least surprising supported stack that actually fits the problem**, and then constrain the agent to its established patterns.

For a small document-centric site, that might be HTML, CSS, and a little JavaScript. For a content-focused site with selective interactivity, a server-rendered or HTML-first approach may be enough. For a stateful collaborative application, an established component framework may eliminate far more complexity than it adds.

The worst option is often neither 'modern' nor 'old-fashioned'. It is the improvised mixture: three component models, two state libraries, an abandoned plugin, and a pile of generated glue that nobody can explain.

## Agent-friendly architecture has to be executable

Readable code helps, but readability does not prove correctness. A better development loop turns assumptions into checks:

1. **State the contract.** Define the expected behavior, the interfaces involved, and the files the agent is allowed to change.
2. **Ground the implementation.** Read repository code, installed package versions, types, and version-matched documentation before adopting an API.
3. **Constrain the surface.** Prefer existing libraries and standard APIs; do not silently add dependencies or invent abstraction layers.
4. **Make the smallest coherent change.** Keep diffs easy to understand, review, and revert.
5. **Execute evidence.** Run formatting, linting, type checks, tests, and relevant integration checks rather than relying on the agent's explanation.
6. **Escalate uncertainty.** When tests are unavailable, behavior is ambiguous, or a dependency change is necessary, say so instead of papering over the gap.

A concise repository-level [`AGENTS.md`](https://agents.md/) can document those rules along with build commands and architectural boundaries. It should be useful guidance, not a novel-length prompt that competes with the code for attention.

There is research behind the importance of tools and feedback. [SWE-agent](https://arxiv.org/abs/2405.15793) showed that how an agent navigates a repository, edits files, and executes tests can materially affect software-engineering task outcomes. More recently, [SWE-Bench Pro](https://proceedings.mlr.press/v306/deng26f.html) has highlighted how challenging multi-file, long-horizon engineering work remains.

For agentic systems, **testability is part of the architecture, not a finishing touch**.

## The real cost is the repair loop, not the first draft

Suppose two stacks can implement the same feature. Stack A produces 120 lines of straightforward code. Stack B needs only 35 lines but requires a plugin, a code generator, and three framework-specific lifecycle rules.

It would be a mistake to declare either stack the winner from that comparison alone. The 35-line version might be excellent, with reliable type checks and well-established patterns. The 120-line version might duplicate complex behavior badly.

The more useful question is what happens *after the first generation*: How many rounds does the agent need to pass tests? How often does it introduce an unrelated regression? How often must a human inspect or rewrite the result? What happens when an API is upgraded six months later?

That is the economic model I care about: **cost per verified, maintainable change**, including human review and future repairs.

It also prevents a misleading conclusion from productivity anecdotes. A [2025 randomized trial by METR](https://metr.org/Early_2025_AI_Experienced_OS_Devs_Study-paper.pdf) found experienced open-source developers took 19% longer on its selected tasks when allowed to use early-2025 AI tools. In a [February 2026 update](https://metr.org/blog/2026-02-24-uplift-update/), METR reported indications of improvement with later tools but stressed that selection effects made the newer measurements unreliable. Neither result proves that AI slows all development or that one framework is better than another. They do show why perceived speed is not a sufficient engineering metric.

## What would actually prove the thesis?

I would like to see a controlled benchmark comparing three approaches: browser-native code, a conventional application using one mature framework, and an equivalent implementation using a newer or more abstraction-heavy stack.

The comparison should use the same feature requirements, agent, model, tool access, test quality, and deployment target. It should include both simple tasks and genuinely stateful applications, and should repeat tasks across several independent runs.

The interesting outcomes would be first-pass test success, total elapsed time, agent/tool tokens, dependency additions, security findings, regressions, and human review time. Then repeat the exercise after a dependency upgrade. That final phase is important: what is easy to generate may not be easy to maintain.

Until such evidence exists, 'AI hates frameworks' is a provocative observation, not a universal engineering law.

## My default: boring foundations, deliberate abstractions

I do not want software development to return to handwritten boilerplate. I want fewer accidental systems layered on top of the actual problem.

I would start with platform capabilities and stable interfaces. I would choose actively maintained dependencies, not merely fashionable ones. I would favor explicit state transitions, straightforward data flows, and documented boundaries. I would give agents repository-specific instructions and tools that expose real failures. And I would expect tests and review to remain part of the process, regardless of how fluent the generated code looks.

This approach is not anti-framework. It is anti-unnecessary uncertainty.

The future of agentic development may involve more code written by machines, but that is a reason to make the foundations **more** predictable, not less. The best stack is the one that lets both humans and agents understand what the system promises, check whether it kept that promise, and change it without guessing.

**Boring is not the opposite of powerful. In software engineering, boring is often what lets powerful tools be trusted.**

---

### Further reading

- Matteo Antony Mistretta, [*Why AI hates modern web frameworks (and loves web standards)*](https://www.codemotion.com/magazine/ai-ml/why-ai-hates-modern-web-frameworks-and-loves-web-standards/), Codemotion, October 2026.
- Liu et al., [*Lost in the Middle: How Language Models Use Long Contexts*](https://aclanthology.org/2024.tacl-1.9/), TACL, 2024.
- Spracklen et al., [*We Have a Package for You!*](https://www.usenix.org/conference/usenixsecurity25/presentation/spracklen), USENIX Security, 2025.
- Yang et al., [*SWE-agent: Agent-Computer Interfaces Enable Automated Software Engineering*](https://arxiv.org/abs/2405.15793), 2024.
- Deng et al., [*SWE-Bench Pro: Can AI Agents Solve Long-Horizon Software Engineering Tasks?*](https://proceedings.mlr.press/v306/deng26f.html), ICML, 2026.
- METR, [*Measuring the Impact of Early-2025 AI on Experienced Open-Source Developer Productivity*](https://metr.org/Early_2025_AI_Experienced_OS_Devs_Study-paper.pdf) and [2026 follow-up](https://metr.org/blog/2026-02-24-uplift-update/).
- MDN, [Web Platform Baseline](https://developer.mozilla.org/en-US/docs/Glossary/Baseline/Compatibility).
- NIST, [Secure Software Development Framework](https://csrc.nist.gov/pubs/sp/800/218/final).
