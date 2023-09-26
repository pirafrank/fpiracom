---
title: A Tiny Try-Catch Equivalent in Bash
subtitle: You can pretty much have it in Bash, too.
description: You can pretty much have it in Bash, too.
category: ["Posts"]
tags: ["Bash", "Linux", "Sys Admin"]
seoimage: "3001/try-catch-bash-seo.jpg"
---

![Bash shell sample image]({{ site.baseurl }}/static/postimages/3001/try-catch-bash.jpg)

While writing bash scripts, you might have found yourself wishing for a try-catch construct to handle errors gracefully. While bash does not have a built-in try-catch mechanism, we can create a simple workaround using functions.

In this blog post, I propose a tiny try-catch equivalent in bash that allows you to handle errors and exceptions in your scripts.

## The problem

Bash scripting lacks a native try-catch construct, making error handling a bit challenging. When an error occurs, the script typically terminates abruptly. By implementing our own try-catch mechanism, we can gracefully handle errors, and what’s more important, perform specific actions based on the error type.

## The solution

As a solution we define a `checkrun` function, which acts as our try-catch block. This function accepts an exit code and an error message as parameters. If the exit code is non-zero, indicating an error, the function prints the error message and exits the script with a non-zero status code.

To demonstrate the concept, let's take a look at the following example:

```bash
function checkrun {
  if [ $1 -ne 0 ]; then
    echo "$2"
    # catch code goes here
    exit 2
  fi
}

function test1 {
  echo "test1" && \
  echo "print 2"
  return 1
}

function test2 {
  echo "test2"
}

test1 && test2
checkrun $? 'Something went wrong...'
```

In the above code snippet, we have two test functions, `test1` and `test2`. Inside `test1`, we intentionally introduce an error using the `return 1` statement. We then call both functions and use `checkrun` to handle any errors that occurred during their execution and quit the script gracefully.

I hope it helps. Thanks for reading.
