{% assign sorted_categories = site.categories | sort %}{% assign sorted_tags_by_name = site.tags | sort_tags_by_name %}{% raw %}---
title: "Some title"
subtitle: "Some subtitle"
description: "Write here a longer description about the blog post."{% endraw %}
"categories": [{% for cat in sorted_categories %}"{{ cat[0] }}"{% unless forloop.last %},{% endunless %}{% endfor %}]
"tags": [{% for tag in sorted_tags_by_name %}"{{ tag[0] }}"{% unless forloop.last %},{% endunless %}{% endfor %}]{% raw %}
seoimage: "300x/some-seo-pic.jpg"
---

![image description]({{ site.baseurl }}/static/postimages/300x/some-pic.jpg)

{% include image.html
url="/static/postimages/2020-06-08/office.jpg"
desc="Image by Markus Spiske from Pixabay"
alt="An office with a desk and a computer mouse"
link="<https://somehost.local/some/article>"
credits="<https://pixabay.com/users/markusspiske-670330/>"
%}

{% gist 40880dbc3e2dcfbdc1dd817b8880fa66 %}

{% youtube abc123abc123 %}

{% vimeo abc123abc123 %}

{% ted abc123abc123 %}

[some text for relative link]({% post_url 2016-09-13-my-jekyll-workflow-part1 %})

{% link static/postfiles/my-jekyll-workflow-part3/policy.txt %}

[Some external link]({{ site.data.external.awesomelink }}){:target="_blank"}{:rel="noopener noreferrer"}

Here goes the blog post text...

I hope it helps. Thanks for reading.
{% endraw %}
