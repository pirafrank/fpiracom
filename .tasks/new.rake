def create_new(item_type)
  site = generate_website()
  categories = site.categories.keys
  tags = site.tags.keys

  date = Time.now
  day = date.strftime('%Y-%m-%d').to_s

  puts "Please enter a title for the #{item_type}:\n"
  title = STDIN.gets.chomp

  formatted_title = title.downcase.split(" ").join("-")
  filename = "#{day}-#{formatted_title}.md"
  contents = <<-STR
---
title: "#{title}"
date: #{day}
subtitle: Some subtitle
description: Write here a longer description about the blog post.
category: #{format_list_as_yaml(categories)}
tags: #{format_list_as_yaml(tags)}
seoimage: "300x/some-seo-pic.jpg"
---

![image description]({{ site.baseurl }}/static/postimages/300x/some-pic.jpg)

{% include image.html
url="/static/postimages/2020-06-08/office.jpg"
desc="Image by Markus Spiske from Pixabay"
alt="An office with a desk and a computer mouse"
link="https://somehost.local/some/article"
credits="https://pixabay.com/users/markusspiske-670330/"
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

---
  STR

  File.open("_#{item_type}s/#{filename}", "w") do |f|
    f.write(contents)
  end
  puts "New post generated"
end

namespace :new do
  desc "create a new blog post"
  task :post do
    create_new("post")
  end

  desc "create a new draft"
  task :draft do
    create_new("draft")
  end
end
