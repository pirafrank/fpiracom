---
title: "NpmAuthenticate in Docker context on Azure DevOps pipeline"
subtitle: "Access to private npm registry while running npm install inside Docker images builded on Azure DevOps pipelines"
description: "Access to private npm registry while running npm install inside Docker images builded on Azure DevOps pipelines"
category: [ "How-tos" ]
tags: [ "Docker", "Azure", "CI" ]
seoimage: ""
---

![default caption](https://fpira.com/static/postimages/3011/44727-001.jpg)

Are you utilizing a Docker container for your application builds? If so, and you're implementing a staged build strategy, you might need to authenticate with your Azure DevOps artifact repository from within the build container. Here's how to achieve that:

1. Create a copy of `.npmrc` file for it to be enriched with credentials

	```yaml
	# a bash task in your Azure pipeline
	cp -a src/.npmrc src/.user_npmrc
	```

2. Use the [NpmAuthenticate](https://learn.microsoft.com/en-us/azure/devops/pipelines/tasks/reference/npm-authenticate-v0?view=azure-pipelines) task in your pipeline to generate the credentials for the private registry.
**Note**: Be sure to specify `.user_npmrc` as `workingFile`. We’ll see later why. Also, being a copy of `.npmrc` it specifies the registries you want to work with. For example, for a file that lives under a `src` subdir in the project root:

	```yaml
	steps:
	- task: npmAuthenticate@0
	  inputs:
	    workingFile: $(System.DefaultWorkingDirectory)/src/.user_npmrc
	```

3. Add a `COPY` directive to your `Dockerfile` to copy `.user_npmrc` , now with credentials, inside the image and be used by `npm`.

	**Tip**: Copy it to `/tmp` to prevent private registry credentials to be eventually included in the finalized Docker image.

	```yaml
	COPY .user_npmrc /tmp/.npmrc
	```

4. Modify your `Dockerfile` to specify the path to the `npm` user config using `NPM_CONFIG_USERCONFIG` environment variable in an `ARG` statement.

	Note: `ARG` represents environment variables utilized only during Docker image build time. This step is needed because, by default, `npm` checks for credentials in the (other) `.npmrc` file, the one in the user’s home folder, but this time we want it to use the one from `/tmp` we copied in the previous step.

	```yaml
	ARG NPM_CONFIG_USERCONFIG=/tmp/.npmrc
	```

**Important**: Ensure these lines are placed **above** the `npm install` command in your Dockerfile! By doing so, the path to your user `.npmrc` file will be accessible during your `npm install` command allowing node modules in private registries to be downloaded and installed.

In the end, your Dockerfile should look like this:

```yaml
FROM node:18
# ...
ARG NPM_CONFIG_USERCONFIG=/tmp/.npmrc
COPY .user_npmrc /tmp/.npmrc
COPY package.json package-lock.json .npmrc ./
COPY src ./src
RUN npm install --omit=dev
# ...
```

That’s it!

I hope it helps. Thanks for reading.

