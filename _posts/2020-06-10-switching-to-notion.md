---
title: "Switching to Notion"
subtitle: First impressions and tips on using Notion as my only productivity tool
description: "First impressions and tips on using Notion as my only productivity tool"
categories: ['Reviews']
tags: ['productivity', 'Notion']
seoimage: 2020-06-10/head.jpg
---

{% include image.html 
url="/static/postimages/2020-06-10/head.jpg"
%}

*Disclaimer: I am not affiliate to Notion or its team.*

In my [previous blog post]({% post_url 2020-06-08-productivity-and-brain %}) about productivity, I wrote about how the brain works and a few tips on choosing a tool.

The truth is that keeping track of how we spend our time is hard. Very hard, and no tool can fit all. Sometimes a simple to-do list on a paper sheet can make it, but we often find ourselves overwhelmed by multitasking and information overload. We then start going all digital hoping to magically fix it all and for geeks like me, that means to risk of getting lost in looking for *the best tool* or being trapped in testing multiple tools.

## My old setup

I have used Evernote for years, it was love at first sight back in 2010. But recently our relation wasn’t that good: no major improvements, terribly slow mobile and web apps. I had accumulated more than 12K notes and felt locked in. I saw this as a chance to start from scratch and restarting by only keeping only meaningful data. I hadn’t much time back then so while looking for an alternative I was ready to trade some features (say *tags*) for a fast and fluid user experience.

I didn’t get that far. My first stop was already on my iPhone. I moved to the built-in Notes app, reviewing and exporting data from Evernote using my Mac as I needed to make changes. It was good enough as a backup plan but I had to find an alternative. I knew that was a temporary solution already showing some cracks. For example, it didn’t play well with my work Windows laptop and Linux Desktop, links kept infecting nearby text and nested folder have not been a thing on iOS until its 13th iteration.

I come up with a private git repository called *notes* (I admit I wasn’t that creative here) and stored text and markdown files, as well as their attachments, in it. Using a git repo for note-taking across multiple devices (Mac, iPad, iPhone, Windows PC, and a Linux Desktop) may sound crazy at least but if you know how to use git from command-line and have apps like [Typora](https://typora.io/) and [Working Copy](http://workingcopyapp.com/) it is a bliss. And it has some nice pros:

- it is highly portable: zero chance to be locked into the platform or fear service termination (because of failure of the company running it, acquisitions, etc.)
- versioning is included (of course)
- you can open the whole folder in Visual Studio Code and have features like search, find and replace, and markdown preview for free
- notes are grep-able, thus you can clone it on your VPS use it from the command line.

But it just wasn’t scaling beyond note-taking so I used Microsoft To-Do to have cross-platform reminders. Multiple tools, multiple web logins, and tasks were separated from notes and related data. It wasn’t as good as I wanted it to be.

## (Re)discovering Notion

I used Notion for the first time years ago when 2.0 wasn’t even a thing. I found it to be very promising yet it didn’t convince me enough to jump off Evernote. Recently, thanks to a colleague, I have rediscovered it and have to admit that things are different.

Today Notion is a great tool to manage your notes, projects, and tasks thanks to flexible data structures supporting multiple views of the same set of data, a *database* in their jargon, custom properties supporting many data types, and even web embeds in the note body. Right now the available *views* are list, table, boards, calendar, and gallery. Which one is the best depends on the property you want to bind the view to and on the content you put into. I’ll show the case for a week agenda as an example in an upcoming blog post. You can then fill the body of your note page with any of the many options you are given. Type `/` to find them out. It supports markdown and more, for example, you can add a toggle list (to hide a section), drop links to other pages and elements, attach files, and embed databases from Notion itself (say tables), PDF files or supported websites. This last option is really interesting, you get Codepen and Figma and have live versions of your snippets or prototypes. Great!

And about the pros of my old setups, it has (almost) all of them:

- portability: you can export to PDF, HTML or a zip with markdown/CSV files plus any attachments
- versioning is supported with history up to 30 days
- live markdown preview and search to anything with support for keyboard shortcuts
- no option to use it from command-line (but I may address this as soon as APIs become publicly available. More on this later).

## Where it excels

{% include image.html 
url="/static/postimages/2020-06-10/backpack.jpg"
desc="It's better to store everything in one place"
credits="https://unsplash.com/@jsweissphoto"
%}

**Different views on your data.** If you work in a team, you may be invited to a shared spreadsheet, but chances are it isn’t used for calculations. Many people use it just because it resembles a table. That’s where tools like Notion are a better fit. You can organize data in tables and easily sort and filter it, even with multiple and nested rules, or change the view from *list*, to *table* or to *board* to group by a particular property. It all adds up without modifying the data structure of the underlying document. Think of them as different points of view on your data.

**Store everything in one place.** Maybe it's hard to convince the whole team to change their main tool., so you can start evaluating it yourself. For me, I don’t think of Notion as a Google Docs or some cloud storage replacement, but more as a something that sits above the many others we use (or are forced to) and acts as a glue. Notion extends this even further with embeds and rich bookmarks.

**Link databases together.** Working with one tool not only helps me to stay focused but also makes it easy to link data together. Type `/link` into a note body to add a link to a page or creating a linked database, or use `/inline` to embed them. These shortcuts work on web, desktop, and mobile.

#### Other nice to have

**Search that works.** It does and fairly predicts the item I'm likely to pick among the results.

**Keyboard shortcuts.** It has a lot of them, you can check them [here](https://www.notion.so/Learn-the-shortcuts-66e28cec810548c3a4061513126766b0). My favorite one is `CMD+p` which works pretty much like *Goto Anything* option in Sublime Text.

**It has a Web Clipper.** And works as I expected, the only acting like the elephant-themed one, properly clipping articles and adding a link to the source. Available for [Firefox](https://addons.mozilla.org/en-US/firefox/addon/notion-web-clipper/) and [Chrome](https://chrome.google.com/webstore/detail/notion-web-clipper/knheggckgoiihginacbkhaalnibhilkk?hl=en).

## How I use Notion

{% include image.html 
url="/static/postimages/2020-06-10/list.jpg"
desc="My databases and notebooks 3 days after sign up"
%}

At the time of writing, I mainly create databases for life wiki, tasks, and note-taking. Here they are:

- **Dashboard**: personal life, work, quick links, side-projects, life goals and things to do today. It all starts with the *Dashboard* database. This just contains links to other pages but it gives me the wide picture;

{% include image.html 
url="/static/postimages/2020-06-10/dashboard.jpg"
desc="The ability to set a cover pic is a nice touch"
%}

- **Learning**: different threads to follow to widen my skills, this handles them all;
- **Vocabulary**: where I store new terms, good to refresh them once a week;
- **Reading List**: despite the title, it contains movies, TV series, papers as well as audiobooks, manuals, and books.

{% include image.html 
url="/static/postimages/2020-06-10/readinglist.jpg"
desc="I like summer paradises. Who doesn't?"
%}

- **Agenda**: the one place for things to do daily, more on this later on;
- **Projects**: a kanban to keep track of all the side-projects often left abandoned;
- **this blog**: separate views for notes, enhancements to [Jekyll](https://jekyllrb.com/), and articles to publish. I'll dig deeper about it in the third installment of this series;
- ***Quick notes* and other notebooks**: plain-old note-taking.

#### Agenda

Now that you have the great picture, let's dive in. While life wikis are strictly personal (and more than data structure, you should care about the content), ideas to create a good agenda are never enough.

The Notion team [has recently announced](https://www.notion.so/What-s-New-157765353f2c4705bd45474e5ba8b46c) nested conditions in database filters, just in time for me to update this article and share it with you.

I made four views: *Calendar* and *Everything* to have the global picture, *To-Do* to show items still not labeled as *Done* and *Progress Today* which present only things I have to do today and progress made. That's a kanban and the only one to use nested filters and right now. They are powerful, but I advise against creating too complex rules. I think of filters as something fluid, tuning them as need and if I want them to stick I may create another *view*. Right now, they are set up like in the picture below.

{% include image.html 
url="/static/postimages/2020-06-10/filters.png"
desc="Nested filters in Agenda"
%}

And if a picture is worth a thousand words, an [interactive template](https://www.notion.so/b1d4e79788fe475c98db50caf4266262?v=3a6788a4de2b4c48830029ee6d5a33c7) is worth even more. Feel free to clone and customize it.

#### Note-taking

Most of my notebooks are *list* views with a given set of properties and custom sorting. If more views are added, they just filter on some properties, and they work a lot like tags in Evernote even though their scope is not global. I also don't display them all, hiding those I don't want via the *Properties* button. You can choose the order, too.

I always create a few properties. The first is *Updated*, set to the last edit date and time. It's a piece of meaningful information worth having. I am actually surprised it is not included in new empty pages by default. Then I usually add a multi-select for *tags* and a URL, useful for bookmarks (tip: if you show URL in the list, you can click it without even open the note!).

And if you want some of these fields to hold defaults, [create a template](https://www.notion.so/Create-your-own-templates-5c033c12ac3b4c1fb4703491be74550d).

And because I want the important stuff to stay on top, I also add a checkbox called *Pinned*, set it as visible, and drag it up in the sort order, above the creation date. Here is [the final result](https://www.notion.so/61ee9e20ef3049d4b2a722ee6b1c188f?v=451df102c4d3402eac49f0c5fe622974).

## Cons of Notion

Of course, nothing is all sunshine and rainbows.

One of the big drawbacks of Notion is how it manages offline notes. Well, how it doesn’t. What they call offline is just caching. Their desktop and mobile apps are a good packing of their React web app, but they are not designed to go offline. If you open a note and then you go offline it will be kept, but there is no way to cache notes, databases, or anything else explicitly or in bulk. It is not even clear what is offline and what is not. If your connection is not good enough, chances are you won’t able to access some of your notes.

Speaking of apps, none of them mobile or desktop supports multi-window forcing you to view one note at a time. Using it for tasks and notes, I often need to have al least two notes side by side. That’s why I use their website and have multiple tabs open.

Another issue for a power user like me is the lack of APIs. Some time ago [they said](https://twitter.com/NotionHQ/status/1174798127695417345) that providing them needs major backend reworking and it looked like those wouldn’t have been here soon. But as I am writing, they have updated their [pricing page](https://www.notion.so/pricing) saying those are *coming soon*. Nevertheless, as of today APIs and integrations with IFTTT or Zapier are still missing, and saving to Notion by sending an email is not possible yet. Digging the web, I have found a set of [unofficial APIs](https://github.com/kjk/notionapi). Although those mostly allow reading, I am going to play with them a bit while waiting for the official ones.

## Conclusion

If you find yourself looking for a tool that can put together Trello, Reminders, Microsoft To-Do, and the different note-taking tools you may be using, Notion is a no-brainer. It works well for storing personal content as well as for managing shared projects, as it can easily handle both tasks and knowledge by creating to-dos, boards, and wikis. Many say it is the successor of Evernote, but it isn’t just a note-taking app, it is much more a toolbox giving you bricks and tools to build your productivity system.

It may take some time to fully assimilate and take advantage of its data structures, find how to build and evolve a setup that fits your needs, but give Notion a chance and let it grow on you.

I hope it helps. Thanks for reading.
