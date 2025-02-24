def valid_date?(date_string)
  return false unless date_string =~ /^\d{4}-\d{2}-\d{2}$/
  begin
    year, month, day = date_string.split('-').map(&:to_i)
    input_date = Date.new(year, month, day)
    # Allow today or future dates only
    input_date >= Date.today
  rescue Date::Error
    false
  end
end

def create_new(item_type)
  site = generate_website()
  categories = site.categories.keys
  tags = site.tags.keys

  date = nil;
  begin
    print "Enter a future date (YYYY-MM-DD) or press Enter to go with today: \n"
    date = STDIN.gets.chomp
    # the loop continues unless the user:
    # just an Enter presses Enter or enters a valid date format
  end while !(date.empty? || valid_date?(date))

  if date.empty?
    date = Time.now
    day = date.strftime('%Y-%m-%d').to_s
  end

  puts "Please enter a title for the #{item_type}:\n"
  title = STDIN.gets.chomp

  formatted_title = title.downcase.split(" ").join("-")
  filename = "#{day}-#{formatted_title}.md"
  contents = <<-STR
---
title: "#{title}"
subtitle: Some subtitle
description: Write here a longer description about the blog post.
categories: #{format_list_as_yaml(categories)}
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
