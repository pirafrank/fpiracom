---
title: "Python http.server for a CORS world"
subtitle: "Making the static HTTP server embedded in Python CORS-compatible"
categories: ['How-tos']
tags: ['Python']
---

Python has a tool to server static content over HTTP. It has had for a long time. You can call it via `python -m http.server 8080`. It is a handy tool that can help on countless occasions, to easily share a folder over a local network or to perform a quick test of how some HTML pages look in a browser.

Recently I've used it for something more unusual: mocking a REST API. I created the path by making the folder tree and the last segment was a file without extension and containing the JSON response. Fine. But it didn’t work because of [CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS) (Cross-Origin Resource Sharing).

What I needed was a CORS-compliant version of `http.server`, properly replying to `OPTIONS` requests made by the browser. So here it is, the code speaks for itself.

{% gist 4089fd5532b4fdafac2bc3d476dd096e %}

I hope it helps. Thanks for reading.