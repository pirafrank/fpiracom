---
title: "Moving up the stack: mastering AI without losing your craft"
subtitle: "Open-source platforms are drawing hard lines against generative AI, but history shows that rejecting a new layer of abstraction never protects software quality. Mastering it does."
description: "From SourceHut and Codeberg AI bans to the PoC trap: why refusing AI misses the abstraction shift, and why senior judgment and sharp specs matter more."
category: [ "Editorials" ]
tags: [ "AI", "LLM", "Cloud", "Software Engineering", "Open-Source" ]
seoimage: 3025/001.jpg
---

{% include image.html
url="/static/postimages/3025/001.jpg"
alt="Editorial illustration of a dark, archaic workshop on the left where a figure stays behind at obsolete consoles, while on the right a towering, luminous scaffold of technological progress - transitioning from heavy industrial gears into glowing digital and collaborative networks - is scaled by engineers ascending to the next layer of abstraction"
%}

When SourceHut updated its Terms of Service in late August 2026, it didn't hide behind ambiguous corporate speak. Instead, users received a brief, uncompromising email notice:

> We're updating the SourceHut terms of service to limit the use of LLMs
> (large language models) and other generative AI tools in your work on
> SourceHut. The changes will take effect on September 10th, 2026.
>
> You can review the changes here:
>
> <https://lists.sr.ht/~sircmpwn/sr.ht-dev/patches/71191>
>
> We have also written a blog post summarizing our rationale, explaining
> how this rule will be interpreted, and how your projects may be affected
> and what you need to know if so:
>
> <https://sourcehut.org/blog/2026-08-27-tos-changes-and-llms/>
>
> If you have any questions, please don't hesitate to reply to this email.

Taking effect on September 10, 2026, this update drew an **absolute, zero-tolerance line against generative AI**: no LLM-written source code, no AI-assisted bug tickets, no generated mailing list patches, and not even new projects that facilitate the use of large language models. Even a minor helper function drafted with an LLM now violates the platform's rules.

SourceHut's blanket ban did not happen in a vacuum. Instead, it is the sharpest escalation yet in a wider split across the open-source ecosystem over what place, if any, generative AI should have in software development. Just weeks earlier, in July 2026, Codeberg's community voted to prohibit repositories consisting *mostly* of AI-generated code, aiming to protect its donation-funded CI/CD runners and storage from a flood of unreviewed vibe-coded projects. Around the same time, Debian took the opposite route by passing a General Resolution centered on **responsible use**, thus permitting AI assistance as long as a human contributor thoroughly understands, tests, and takes full responsibility for what gets shipped.

Ideological manifestos aside, the frustration driving these policies is easy to understand. Volunteer maintainers are drowning in drive-by bug reports hallucinated by a prompt, bloated pull requests from contributors who cannot even explain how their own patch works, and repositories generated overnight with zero architectural planning. That noise is real, and ignoring it would be naive.

Yet, **responding to bad usage by banning the underlying technology entirely is a category error.** You cannot simply ignore AI, and pretending we can freeze software engineering in 2022 is both futile and counterproductive.

## Looking for a middle ground

In a quest to save the new without drowning in it, we look at how some of the most seasoned engineers in our industry have navigated this shift. Take Linus Torvalds, for example, hardly someone known for chasing Silicon Valley hype or tolerating sloppy engineering.

Earlier in 2026, Torvalds openly acknowledged using AI to build the Python visualizer for a hobby audio project because he didn't care to spend weeks wrestling with a language outside his daily wheelhouse. By October, he was using Claude Code to help draft a series of Linux kernel patches tackling a long-standing multi-core file-read bottleneck, while simultaneously calling out the very real burnout caused by low-effort, AI-generated bug reports hitting kernel maintainers. On stage at Open Source Summit he made an even sharper observation: developers brag about how much of their code is written by AI, forgetting that **100% of their code** is already written by compilers, yet nobody claims the compiler is the author of their software.

That distinction captures the entire debate. Treating an LLM as a magic box that replaces engineering judgment produces garbage. Treating it as a high-leverage tool inside a disciplined workflow changes how fast an engineer can explore, validate, and build.

And that's exactly where we should steer the ship.

## How developers are actually adopting AI

Strip away the marketing noise, and developers today tend to fall into three distinct camps:

* **Blind delegation (a.k.a. "vibe-coding"):** Prompting an agent until the UI looks right or a basic happy-path test passes, merging hundreds of lines without reading them, and hoping nothing breaks under load.
* **Dogmatic refusal:** Rejecting AI tools altogether out of principle, aesthetic purism, or fear. The cost here isn't immediate failure, but gradual irrelevance. Spending hours manually writing repetitive glue code, parsing boilerplate, or grepping unfamiliar APIs doesn't make a system more noble. That approach just leaves less time for architecture and verification.
* **Structured, human-led augmentation:** Using models deliberately as an interactive compiler, rubber duck, and drafting engine while keeping design, invariants, and final review strictly in human hands.

## The PoC trap: from four-minute demo to real production

The trap with the first camp, blind delegation, is that it works remarkably well right up until the moment real users arrive.

The trajectory is usually something like: on day one, someone opens an AI editor, generates a sleek to-do app in four minutes, deploys it, buys a `.ai` domain, and declares traditional developers obsolete. Confidence then falls off a cliff the instant their first real user reports they cannot sign up, triggering an endless prompt-and-pray fix loop, sycophantic *"You're absolutely right!"* responses that fix nothing, CORS errors, and an API key accidentally pushed to a public GitHub repository for a sky-high bill, until they finally bin the idea, or pause and start studying instead.

The underlying lesson isn't that AI is useless for building products, but that **drafting a proof of concept and operating a real product are two fundamentally different disciplines.**

Using an LLM to scaffold an MVP, test a UI flow, or validate an idea over a weekend is a legitimate superpower. In a PoC, speed is everything and technical debt is disposable. Launching and sustaining a real SaaS or production system is another story entirely:

* **Day-zero concerns become existential:** Authentication flows, cross-origin policies, secrets management, rate limiting, and database schema migrations do not forgive guesswork.
* **Architecture determines survivability:** Without clean module boundaries, deliberate state management, and sound architectural patterns, every new feature breaks two existing ones.
* **Shipping is only the starting line:** Real software lives in post-launch maintenance, including observability, backward compatibility, dependency upgrades, security patches, and debugging live incidents under pressure.

You cannot prompt your way out of an architectural dead end if you don't know what a good architecture looks like in the first place.

## Every leap forward is a layer of abstraction

Whenever a major technological shift arrives in engineering, it triggers the same anxiety: *if the machine handles this step for us, won't we stop understanding how things work?*

History has answered that question multiple times:

* **Human calculators vs. electronic calculators:** Before electronic computing, rooms full of human *computers* spent weeks manually calculating ballistic and astronomical tables. Automated calculators didn't eliminate mathematicians; they freed them from arithmetic fatigue so they could tackle computational physics, numerical simulation, and problems that were previously unreachable.
* **Assembly vs. high-level languages and compilers:** When early programmers moved from raw machine code and Assembly to C and higher-level languages, purists argued that developers would lose touch with the hardware. They were partly right since most developers stopped hand-optimizing register allocations, but completely wrong about the outcome. Compilers gave us the leverage to build operating systems, databases, and global networks that no human team could ever maintain in raw Assembly.
* **Plain text editors vs. modern IDEs:** Writing code in a bare text editor with nothing more than `grep` and memorized standard-library headers required immense mental overhead just to keep types and signatures straight. Modern IDEs with AST-aware static analysis, IntelliSense, and automated refactoring didn't make programmers dumber. Instead, those tools moved cognitive load away from syntax recall and toward system design.

AI-assisted development is simply the next step on that exact same staircase. We are moving one level of abstraction higher: from manually typing every syntactic token to specifying intent, constraints, and architecture, and verifying the resulting implementation.

## The paradox of higher abstraction and the statistical ceiling

Here is the part that both AI evangelists and AI doomers routinely miss: **moving up one level of abstraction paradoxically requires *more* foundational knowledge and brain power, not less.**

When you write Assembly, your mistakes are local and immediate. When you work on top of a compiler, an async runtime, a distributed orchestrator, and an LLM generating implementation blocks, your blast radius is orders of magnitude larger. The bottleneck shifts entirely from *typing* to *thinking*.

To understand why deep expertise matters more now rather than less, look at what an LLM actually is. Beneath the conversational interface, a large language model is a statistical engine operating over learned token distributions. Left to its own devices with vague instructions, its default output inevitably regresses toward the **statistical average** of the code it was trained on. Average code is acceptable for boilerplate and scripts, but very likely to be dangerous for concurrency, security boundaries, performance-critical paths, and complex business logic.

Pulling an LLM out of that statistical mediocrity and raising the quality bar requires telling it *precisely* how a problem should be solved. That includes specifying data layouts, failure modes, edge-case invariants, and architectural trade-offs. You cannot write a sharp specification for a domain you do not deeply understand.

Even the frontier labs' own progress confirms this dynamic. Notice how recent leaps in *smarter* coding and reasoning models have not come from brute-force pre-training retrains on ever-larger piles of raw internet text, but from post-training tuning (reinforcement learning, verifiable rewards, curated trajectories, and strict evaluation rubrics). Models become genuinely capable only when guided by clear definitions of correctness and well-structured specifications. The exact same rule applies at the engineering desk: better specs and end-to-end process mastery dictate the ceiling of the output.

## Why senior engineers are the irreplaceable guardrail

This reality exposes a dangerous blind spot in how many companies and enterprises are currently reacting to AI. Treating senior engineers as an expensive line item to trim because *AI writes the code now* is a profound strategic mistake.

Today's senior developers represent **the last generation of engineers trained entirely pre-AI**, people who had to build unassisted, first-principles mental models of how networks, operating systems, databases, and distributed applications behave when things go wrong. Far from being obsolete, they are the exact people to:

* **Set the architectural rails** so probabilistic code generation stays coherent across a large codebase;
* **Write high-precision specifications** that force models above their statistical baseline;
* **Step in when the model hits a wall**, diagnosing subtle race conditions, memory leaks, or production regressions that an LLM can neither reproduce nor reason through on its own.

Laying off senior talent in the name of AI efficiency doesn't create a leaner engineering organization. It wastes the very institutional knowledge required to steer the tool and rescue the product when automation falls short.

## What a sensible approach looks like in practice

If you want the upside of AI tooling without turning your codebase into unmaintainable slop, the rules are surprisingly straightforward:

1. **Never outsource architecture or invariants.** The platform is known by the people who built it. Data models, module boundaries, concurrency strategies, and failure handling belong to you. If you cannot sketch how the system works on a whiteboard before opening an editor, no prompt will rescue the design.
2. **Invest in specifications before generation.** Treat clarity of intent as your primary leverage. The sharper your constraints, interfaces, and acceptance criteria, the further you push the model away from generic average-case code.
3. **Treat generated code like an untrusted patch.** Every line committed to a repository carries *your* name and *your* maintenance liability. Read diffs line by line, question non-obvious choices, and delete anything overly clever that you wouldn't have written yourself.
4. **Delegate the mechanical, keep the cognitive.** Use models to scaffold boilerplate, write exhaustive test matrices, keep documentation updated, translate formats, explore unfamiliar libraries, draft PR comments and backlog items, or spot subtle logic bugs during review. But keep critical-path algorithms, security boundaries, and operational ownership under tight human control.

## Adapt, or be left behind

Humans are not being written out of software engineering. We are being pushed further up the stack, just as we were when compilers replaced hand-assembled opcodes. Leadership in engineering has never been about who can type characters the fastest. Instead, it has always been about judgment, clarity of thought, and accountability for what ships.

You don't have to buy into the hype, and you certainly shouldn't surrender your craft to an autocomplete engine. But refusing to engage with the tool at all won't preserve the golden age of programming. Like every technological shift before it, the choice isn't whether the abstraction arrives, but whether you master it with discipline or let it overwhelm you.

If you found this perspective useful, consider sharing it with colleagues or on social media. Engaging in thoughtful discussion about the responsible adoption of AI in software engineering is crucial as we navigate this evolving landscape.

I would love to hear your thoughts and experiences with AI in your own projects. Feel free to reach out or leave a comment to continue the conversation.

Thanks for reading.
