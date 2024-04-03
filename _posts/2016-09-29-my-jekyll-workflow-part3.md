---
layout: post
title: "My Jekyll workflow: Part 3"
subtitle: "Hosting the blog static resources on Amazon S3"
description: "Hosting static resources of a Jekyll blog on Amazon S3"
category: ['Tutorials']
tags: ['Jekyll','Blogging','Pythonista','AWS']
---

Welcome again to the *My Jekyll workflow* series. In [part 1]({{ site.baseurl }}/blog/2016/09/my-jekyll-workflow-part1) I wrote about my basic workflow and in [part 2]({{ site.baseurl }}/blog/2016/09/my-jekyll-workflow-part2) on how to improve it.

There's still more room to improve and I drove that way.

### Going *simple* with Amazon storage

I want to offload my little VPS resources and bandwidth by hosting `/static` files to Amazon S3 storage. It is friendly to use and cheap: for a blog it should cost less then $1 per month.

First of all I created an account on AWS. They give you 12-month [free tier](https://aws.amazon.com/free) upon sign up.

#### Configuring AWS

Configure AWS is easy and flexible. I created a bucket in seconds and (mandatory) enabled the *static file hosting* option  for it (read more about [here](https://docs.aws.amazon.com/AmazonS3/latest/dev/HowDoIWebsiteConfiguration.html)).

Next, I've created two IAM roles, one admin with full access to S3 and one to set with access to only the said bucket. JSON-based policies are very powerful and provide fine-grained access control. Head over [here](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_examples.html#iam-policy-example-s3) to know how to setup an IAM role with read and write access to a specific bucket. I made available the policy I use [here]({{ site.baseurl }}/static/postfiles/my-jekyll-workflow-part3/policy).

#### Uploading statics to S3

Upload on the go to S3 can be challenging, especially on iOS. Since there's no solution in sight, I decided to write an app for that and release it in the App Store by the end of this year.

Right now, I use SFTP to perform on-the-go static file uploads. I already had a repository for static resources (see [part 2]({{ site.baseurl }}/blog/2016/09/my-jekyll-workflow-part2)), so I've set up [aws cli](https://github.com/aws/aws-cli) on server and added a post-run [script](https://gist.github.com/pirafrank/00529b9c07d79389847aec173bd74abf) in jekyll-deployer `config.json`. It's a few bash lines. It commits new static resources (I upload via SFTP) and then [syncs](https://docs.aws.amazon.com/cli/latest/reference/s3/index.html) the entire repo to S3. It is only run when deploying *master*.

#### Nginx redirect

Next step is to tell nginx to redirect requests to `https://fpira.com/static` to the S3 bucket. I did so using a *rewrite* in the website configuration.

To avoid extra charges, I've added the rewrite only in the stable config letting it load static files at `https://unstable.mywebsite.com` from the VPS. See the excerpt below.

```
location /static/ {
    rewrite ^/static/(.*) https://fpira-s3-media.s3-website-eu-west-1.amazonaws.com/fpira.com_static/static/$1 break;
    expires max;
}
```

### Final words

This was the last post of the series. I hope you enjoyed it. I'll keep on improving my workflow and publishing about it.

Thanks for reading.
