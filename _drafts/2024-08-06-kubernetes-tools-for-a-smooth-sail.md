---
title: "Kubernetes tools for a smooth sail"
subtitle: "A collection of essential CLI tools to work with Kubernetes"
description: "A collection of essential command-line tools to work with Kubernetes"
category: [ "Posts" ]
tags: [ "Kubernetes", "terminal setup", "Tools", "Linux" ]
seoimage: ""
---

![default caption](https://fpira.com/static/postimages/3008/57860-untitled.png)

Kubernetes is right now one of the most common systems to deploy containerized services at scale and has become the de facto standard for container orchestration in the industry. You need the right tools to take the most out of it. Here are a few which have become my daily drivers helping deploying, monitoring, and debugging through the lifecycle. I consider them the bare minimum for people working with Kubernetes.

And most important, they are perfect citizens for your shell environment, so you can get a smooth experience out of them.

### kubectl

The first step to interact with you k8s cluster. It's the most important one and so obvious it's here just for completeness sake. By default it looks for config into `~/.kube/config`. The file is a YAML one. More info [here](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands).

### kubectx + kubens

You may have many config files in `~/.kube` folder. Instead of making shell aliases to pass them to `kubectl` more easily, merge them and switch among clusters and namespaces using `kubectx` and `kubens`.

`kubectx` is a _faster way to switch between clusters (contexts)_ _in kubectl_ and `kubens`_utility to switch between namespaces in Kubernetes_. You can see them in action on [their GitHub page](https://github.com/ahmetb/kubectx).

### helm

_The package manager for Kubernetes_ ([website](https://helm.sh/))_._ It allows you to gather, ship and install the multiple yaml files your application needs as _charts_. Each chart can be installed as a _release_ in your cluster. [artifacthub.io](https://artifacthub.io/) is a public store for charts, started by the Helm guys, it's now supported as a sandbox project by the [CNCF](https://www.cncf.io/sandbox-projects/). But you can host yours too to keep your charts private. Pretty much the same way Docker Hub is a public registry for Docker images but you can have yours, too.

Where to start ? Check the [quickstart](https://helm.sh/docs/intro/quickstart/) on their website.

I also use [this cheat sheet](https://github.com/RehanSaeed/Helm-Cheat-Sheet) as a reference.

### kustomize

Part of `kubectl` since [version 1.14](https://github.com/kubernetes-sigs/kustomize), it lets you split and organize YAML files containing Kubernetes API objects. It also helps you customize, hence the name, third-part YAML configurations without touching those files and provide a more immediate approach then `helm` does. The output is a file, a bundle you can apply via kubectl.

### stern

With all those different application versions running and different pods interacting with each other, it can be hard to follow logs simultaneously. [Stern](https://github.com/wercker/stern) comes to help. It allows you to tail logs of multiple pods and containers by just providing a regex of names of pods/controllers to follow as argument. Options to print timestamps as well as colorful output are available, too.

### Installing them

For all of them to work, the only requirement is for you to have `~/.kube/config` or `KUBECONFIG` in place. They will look for clusters in there and default to the currently selected cluster and namespace.

I made a script to install them all. It is part of my [workspace repo](https://github.com/pirafrank/workspace/blob/main/setups/setup_cloud_clients.sh), my one-stop shop for scripts and environment setup. You can simply clone the workspace repository and run it straight away like this:

```bash
git clone -n https://github.com/pirafrank/workspace.git workspace
cd workspace
git checkout 07db971  # in case I move things around in the future
cd setups
./setup_k8s_tools.sh
```

The script downloads the binaries and copies them to `~/bin2` folder by default. You may need to add `~/bin2` to your `PATH`. Export the `BIN2_PATH` env var before running the script to customize installation path. The script won’t modify your `PATH` in any case.

### Conclusion

Those tools are a bless if you work across multiple clusters and namespaces, which is very likely if you organize your software deployments along the [best practices](https://kubernetes.io/docs/concepts/configuration/overview/).

I hope it helps. Thanks for reading.

