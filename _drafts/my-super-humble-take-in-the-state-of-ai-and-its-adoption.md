---
title: "My super humble take in the state of AI and its adoption"
subtitle: "Three perspectives on AI as a tool, an infrastructure problem, and an adoption problem"
description: "A personal view of AI from the developer, sustainability, and adoption perspectives, with a long-term preference for efficient open-weight models running at the edge."
category: [ "Posts" ]
tags: [ "Cloud", "hardware", "Linux", "Privacy", "Tools" ]
seoimage: 3022/001.jpg
---

{% include image.html
url="/static/postimages/3022/001.jpg"
alt="Editorial illustration contrasting centralized AI data centers with an efficient open-weight model running on a personal computer"
%}

I have been thinking about AI for a while, mostly from the perspective of someone who has to build and maintain software rather than sell a story about it. My current position is not especially original, and it is not meant to be definitive. It is simply the way the trade-offs look to me today.

I keep coming back to three questions:

1. What is AI like as a tool for developers?
2. Can the current infrastructure model scale financially and environmentally?
3. What does responsible adoption look like in open-source projects and businesses?

## AI from a developer point of view

The first thing I would like to remove from the conversation is a little theatre.

AI is a tool. A powerful tool, sometimes a surprisingly useful one, but still a tool. A compiler is a tool. A debugger is a tool. A search engine, a database, a shell script and a spreadsheet are tools. We do not usually discuss whether a compiler has “changed everything” every time a new version is released. We ask whether it produces a correct binary and whether it fits the work.

The amount of discussion around AI is partly proportional to how disruptive the tool appears to be. When a tool changes who can perform a task, lowers the cost of experimentation or moves a boundary that looked fixed, people talk about it. That is reasonable. It does not mean that every discussion is useful, or that the tool has removed the need for judgment.

For a developer, an AI assistant can be useful for exploring an unfamiliar API, producing a first draft, translating between languages, explaining an error, generating test cases or reducing the amount of typing required for a repetitive change. It can also confidently suggest a wrong API, invent a dependency, miss a security boundary or make a codebase harder to understand.

The useful unit is therefore not “AI-generated code”. The useful unit is a change that a developer can inspect, test, explain and maintain.

That distinction matters more as tools become more autonomous. If an agent opens a pull request, the responsibility for the pull request still belongs to the project and its maintainers. The agent does not review its own assumptions in the same way a human maintainer does, and a green test suite does not prove that the new behaviour is desirable.

I am happy to use a tool that saves time. I am less interested in pretending that using it makes the surrounding engineering work disappear.

## AI sustainability

The hidden cost of AI is becoming harder to ignore. The cost is not only the monthly subscription or the token bill. It includes the hardware, the electricity, the cooling, the water, the networking, the buildings, the local grid upgrades and the people needed to operate all of it.

The [International Energy Agency’s *Energy and AI* analysis](https://www.iea.org/reports/energy-and-ai/) describes data centres as a growing source of electricity demand. The [Lawrence Berkeley National Laboratory’s 2025 data-centre update](https://seta.lbl.gov/publications/united-states-data-center-energy-2025) also shows how uncertain—and potentially very large—the future demand range is. Water use is not a single fixed number either: it depends on the cooling system, the local climate, the electricity mix and whether we are discussing withdrawal or actual consumption. The [Berkeley water-use research](https://www.law.berkeley.edu/research/clee/research/wheeler/water-innovation/data-center-water-use/) is a useful reminder that the local details matter.

None of this means that every data centre is an environmental disaster, or that AI has no useful applications. It means that “we will build more capacity” is not a neutral technical answer. Large facilities need power and cooling, often near existing infrastructure and populated areas. They can create noise, compete for water, require new transmission capacity and leave businesses exposed to a recurring operating cost that is difficult to predict.

At some point, the losses are no longer a reasonable user-acquisition cost. Companies burn their own GPUs or rent them at a price that has to be recovered from customers. Customers, in turn, are likely to pay more as usage becomes more valuable and providers become more careful about capacity. The economics can work for some workloads, but it is difficult to see unlimited centralized inference as the only sustainable destination.

### Open weights against closed models

My long-term preference is open-weight models. I use “open-weight” deliberately: publishing model weights does not necessarily mean publishing the training data, the complete training pipeline or every component needed to reproduce the model. But weights are portable in a way that a hosted API is not.

An open-weight model can be evaluated, quantized, adapted and deployed by different people on different hardware. A business can keep sensitive data inside its own boundary. A developer can replace one serving stack with another. A community can find bugs, build integrations and keep using a model even if the original provider changes its pricing or product strategy.

Closed models can be better for a particular task, and hosted services are often the most convenient way to get started. Convenience is a real benefit. The problem is making a centralized, closed service the default answer for every workload, including workloads that do not need frontier-scale capability or an external data boundary.

I wrote about this direction in a [post about usage-based AI billing and the hidden cost of cloud AI](https://www.linkedin.com/posts/pirafrank_github-copilot-is-moving-to-usage-based-billing-activity-7454629214097432576-vWTm?utm_source=share&utm_medium=member_ios&rcm=ACoAAAs8XocBJPtxyqv7ddC5MGjOElOSxUbeG8E), and made the same broader argument in a [Mastodon post about open weights and edge computing](https://mastodon.social/@pirafrank/116953617047930401). The short version is that I expect AI to follow a familiar path: personal computers democratized computing, smartphones put the internet in our pockets, and efficient open-weight models can make useful AI a local commodity.

That path has a privacy advantage as well. If a model runs on hardware I control, the prompt and the result do not need to cross somebody else’s boundary. This is not a complete privacy solution—local software can still be badly configured, and the model itself can have licensing and provenance issues—but it removes one large and often invisible dependency.

### Edge computing against data centres

The edge will not replace data centres for every workload. Frontier training, large shared services and tasks requiring unusual amounts of context will continue to need centralized infrastructure. The point is not to move everything to a laptop.

The point is to stop treating centralization as the only design. A small or medium model can handle many local tasks. Mixture-of-experts architectures, quantization, better runtimes and specialized hardware reduce the amount of computation needed for a useful answer. Inference can be placed where the data and the user already are, while exceptional workloads can still be sent to a service that is worth the cost.

This is a more resilient architecture: local by default, remote when needed, and explicit about what leaves the device.

## AI adoption

The adoption question is different for an open-source project and for an enterprise. Both need judgment, but they have different incentives and different failure modes.

### Open-source projects

Open-source projects are not factories for producing code at any cost. They are communities responsible for code that other people will run, depend on and maintain.

Linus Torvalds’ position on AI in the Linux ecosystem is a useful example of pragmatism. In a [Linux kernel mailing-list message](https://lore.kernel.org/linux-media/CAHk-=wi4zC+Ze8e+p3tMv8TtG_80KzsZ1syL9anBtmEh5Z40vg@mail.gmail.com/), he describes AI tools as something developers can use, while keeping the focus on the quality and reviewability of the resulting patch. That is the right boundary: the origin of a change matters less than whether the change is correct, understandable and maintainable.

The same principle applies to project policy. A contributor should not be required to disclose every editor feature or autocomplete suggestion, but a project can reasonably require tests, clear commit messages, reproducible behaviour and human review. Generated code must enter the same maintenance process as handwritten code.

Salvatore Sanfilippo, the creator of Redis, has approached AI from a similarly practical direction in [his discussion of coding agents and software development](https://www.youtube.com/watch?v=Dbf__V0yJJ8). The interesting question is not whether a model wrote a line of code. It is whether the surrounding process preserves understanding and quality.

There is also a sustainability issue for open source. If maintainers use hosted tools for every task, the project may become dependent on a provider, a paid account or a model whose behaviour changes without notice. Local open-weight models do not solve all of that, but they offer more control and more options for contributors who can run them.

### Enterprises and the magic-wand problem

In the enterprise, the most damaging misunderstanding is that AI is a magic wand for multiplying output, capacity and money. It is not. A tool can reduce the cost of some activities while increasing the cost of review, integration, governance and maintenance.

There are at least three budgets to consider:

* the financial budget for subscriptions, APIs, GPUs, storage, networking and operations;
* the cognitive budget developers spend verifying, correcting and understanding generated work; and
* the technical-debt budget created when a system accumulates code that nobody fully understands.

An AI initiative that ignores any of these budgets is not free productivity. It is often deferred cost.

Privacy belongs in the same conversation. A company that cares about protecting its data should also care about which models process that data, which companies operate those models, how prompts are retained, and what happens when terms or ownership change. This applies to ordinary businesses as much as to highly regulated ones. Sensitive information does not become safe merely because it was pasted into a familiar chat interface.

Open-weight models make stronger privacy boundaries possible, but they introduce a different operational burden. A company needs hardware capable of running the chosen model, a serving runtime, model updates, monitoring, access controls, backups and people who understand the system. Good local hardware is still expensive, consumes power and can be difficult to maintain. “Run it locally” is an architectural direction, not a zero-cost checkbox.

That burden is still preferable in some cases to sending all data and all inference to a vendor, especially when the workload is stable and the organization can amortize the hardware over time. In other cases, a hosted model is the more responsible choice. The decision should follow the data, the workload, the required quality and the actual total cost—not a slide promising infinite leverage.

## A partial escape route

The answer is not fully available today, but the path is becoming clearer.

We need models that are smaller, more efficient and easier to serve; hardware designed for local inference; better data and evaluation pipelines; and software that can choose between local and remote execution. The [Moonshot AI founder’s discussion of model development and the surrounding talent and research pipeline](https://www.chinadaily.com.cn/a/202603/25/WS69c3a773a310d6866eb3fd5f.html) points in the same direction: progress is not only about making a larger model, but about improving the system that produces and operates it.

Research such as [BitNet](https://arxiv.org/abs/2310.11453) and [BitNet b1.58](https://arxiv.org/abs/2402.17764) is particularly interesting because it treats lower-bit models as an architectural opportunity, not only as a compression trick applied after the fact. Efficient inference on ordinary CPUs is also being explored in projects such as [bitnet.cpp](https://arxiv.org/abs/2410.16144).

None of these developments makes the current data-centre economy disappear. They do make a different future plausible: capable models running on devices people and organizations already control, with centralized services reserved for tasks that genuinely need them.

That is my humble take. AI is a useful tool, but it is not a substitute for engineering responsibility. Its current infrastructure is powerful, expensive and difficult to scale indefinitely. Adoption will be healthier when we treat privacy, cognition, technical debt and environmental cost as part of the feature—not as someone else’s problem.

Thanks for reading.
