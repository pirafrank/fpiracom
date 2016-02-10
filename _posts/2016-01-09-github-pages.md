---
layout: post
title: Setup HTTPS on Github Pages with a custom domain
subtitle: A simple guide to make custom domains and HTTPS work with Github Pages
categories: webdev
description: Setup and 
keywords: https,github,github pages,custom domains,cloudflare,domains,website,dns
---

Github Pages is great. You can host your blog for free and since you like coding it's also funny!
But you want to be professional and let people access your blog from a custom domain and by using on HTTPS connection.

In this guide, a quick and straightforward way to get HTTPS on Github Pages. It's not that difficult.

### Step 1: Buy a domain 

If you've done it, this is where to start. Be sure the registrar offers you a control panel to customise DNS servers for the domain.

### Step 2: DNS redirect

1 - Buy the domain you like

2 - Create a free cloudflare account

3 - Add your custom domain to cloudflare and follow the procedure

4 - Add your custom domain to CNAME file in repository root

5 - Create an A record on cloudflare to point to github servers (follow [this guide](https://help.github.com/articles/tips-for-configuring-an-a-record-with-your-dns-provider/))


### Step 3: Get free HTTPS

**Please note that this solution is just palliative for your website visitors.** Github Pages dosen't support HTTPS connection for custom domains. The furthest you can go is to use cloudflare as proxy and encrypt connection between the user and cloudflare. Thus Cloudflare to Github connection will remain not encrypted.

If you still want to have this facade security, follow the procedure below.

1 - Go to cloudflare and enable it (just be sure you have an orange cloud near the DNS entry, if not click the cloud to make it orange)

2 - In *Crypto*, enable *Flexible SSL*

3 - In *Page Rules*, create rules to *always use HTTPS*. You need to create two of those: one for yourcustomdomain.com and one for www.yourcustomdomain.com.

4 - Wait a could of hours

You're done! Easy, isn't it?

Thanks for reading.
