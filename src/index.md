---
title: Hacker News RSS
---

## Overview

hnrss.org provides custom, realtime RSS feeds for [Hacker News][].

The following feed types are available:

| | |
|----------:|----------|
[**Firehose**](#firehose-feeds) | New [posts](https://hnrss.org/newest) and [comments](https://hnrss.org/newcomments) as they arrive.
[**Front Page**](#firehose-feeds) | New [posts](https://hnrss.org/frontpage) as they appear on the front page.
[**Searches**](#search-feeds) | New [posts](https://hnrss.org/newest?q=redis) and [comments](https://hnrss.org/newcomments?q=linux) matching a given search term.
[**Replies**](#reply-feeds) | New comments in reply to a particular [user](https://hnrss.org/replies?id=jerf) or [comment](https://hnrss.org/replies?id=17752464).
[**Points**](#activity-parameters) | New [posts](https://hnrss.org/newest?points=300) with more than N points.
[**Activity**](#activity-parameters) | New [posts](https://hnrss.org/newest?comments=250) with more than N comments.
[**Self-posts**](#self-post-feeds) | New "[Ask HN](https://hnrss.org/ask)" and "[Show HN](https://hnrss.org/show)" posts, along with [polls](https://hnrss.org/polls).
[**Jobs**](#job-feeds) | New [hiring posts](https://hnrss.org/jobs) made by YC startups along with comments from the monthly ["Who is hiring?"](https://hnrss.org/whoishiring/jobs) threads.
[**Users**](#user-feeds) | New [posts](https://hnrss.org/submitted?id=jacquesm) and [comments](https://hnrss.org/threads?id=tptacek) made by a given user.
[**Threads**](#thread-feeds) | New comments made [in a given thread](https://hnrss.org/item?id=17821181).
[**Formats**](#feed-formats) | In addition to RSS, all of the above are also available in [Atom](https://hnrss.org/newest.atom) and [JSON Feed](https://hnrss.org/newest.jsonfeed) formats.

[Hacker News]: https://news.ycombinator.com/
[Ask HN]: https://hnrss.org/ask
[Show HN]: https://hnrss.org/show
[polls]: https://hnrss.org/polls
[jobs]: https://hnrss.org/jobs
[whoishiring]: https://hnrss.org/whoishiring/jobs

## Details

Each feed is [valid RSS][] served over [HTTPS][].

[valid RSS]: https://validator.w3.org/feed/check.cgi?url=https%3A%2F%2Fhnrss.org%2Fnewest
[HTTPS]: https://www.ssllabs.com/ssltest/analyze.html?d=hnrss.org

### Firehose Feeds

The "firehose" feeds contain all new posts and comments as they appear
on Hacker News:

<pre>
https://hnrss.org/newest
https://hnrss.org/newcomments
</pre>

For just the posts that have appeared on the front page:

<pre>
https://hnrss.org/frontpage
</pre>

If the firehose feeds are a bit too noisy for you, [read below](#activity-parameters) on
filtering them with the `points` and/or `comments` parameters.

### Search Feeds

You can get a feed of new posts and/or comments containing keywords by
using the `q=KEYWORD` parameter. For example:

<pre>
https://hnrss.org/newest?q=Django
https://hnrss.org/newcomments?q=WordPress
</pre>

If you want a single search feed but multiple keywords, separate the
keywords with " OR ":

<pre>
https://hnrss.org/newest?q=git+OR+linux
</pre>

### Reply Feeds

Keep an eye on replies to your comments:

<pre>
https://hnrss.org/replies?id=jerf
</pre>

Use a comment ID to follow replies of a particular comment:

<pre>
https://hnrss.org/replies?id=17752464
</pre>

### Self Post Feeds

Ask HN, Show HN, and polls are available:

<pre>
https://hnrss.org/ask
https://hnrss.org/show
https://hnrss.org/polls
</pre>

### Job Feeds

Job opportunities from YC funded startups:

<pre>
https://hnrss.org/jobs
</pre>

Top level comments in threads created by the whoishiring bot:

<pre>
# Comments from "Who is hiring?" threads
https://hnrss.org/whoishiring/jobs

# Comments from "Who wants to be hired?" threads
https://hnrss.org/whoishiring/hired

# Comments from "Freelancer? Seeking freelancer?" threads
https://hnrss.org/whoishiring/freelance

# All of the above
https://hnrss.org/whoishiring
</pre>

If you're interested in something in particular, you can apply a
`q=KEYWORD` parameter to only return relevant comments. For example,
filter the top-level "Who is hiring?" comments to only those
containing "React Native":

<pre>
https://hnrss.org/whoishiring/jobs?q=React+Native
</pre>

### User Feeds

If you don't want to miss a post or comment by a given user, you can
subscribe to that user's feed:

<pre>
https://hnrss.org/submitted?id=USERNAME # posts
https://hnrss.org/threads?id=USERNAME   # comments
https://hnrss.org/user?id=USERNAME      # everything
</pre>

### Thread Feeds

A feed of new comments on a particular post can be found at:

<pre>
https://hnrss.org/item?id=THREAD_ID
</pre>

With `THREAD_ID` the numerical ID found in the URL when viewing the
comments page.

### Feed Options

You can modify any feed's output using URL parameters. Multiple
parameters can be applied at the same time by joining them with an
ampersand.

#### Activity Parameters

You can apply a `points=N` or `comments=N` parameter to any feed to
filter the results so only entries with more than N points or comments
are shown:

<pre>
https://hnrss.org/newest?points=100
https://hnrss.org/ask?comments=25
</pre>

You can also combine both parameters:

<pre>
https://hnrss.org/show?points=100&comments=25
</pre>

Unfortunately, `/newcomments` [does not work][] with a `points=N`
parameter.

[does not work]: https://github.com/algolia/hn-search/issues/55#issuecomment-73599729

#### Search Parameter

By default, searches on posts only look at titles. If you want to
search against the submitted URLs themselves, use the `search_attrs`
parameter.

Here are some examples:

<pre>
# Search for posts with "WordPress" in the title only
https://hnrss.org/newest?q=WordPress

# Search for posts with 'WordPress' in the URL only
https://hnrss.org/newest?q=WordPress&search_attrs=url

# Search for posts with 'WordPress' in the title or URL
https://hnrss.org/newest?q=WordPress&search_attrs=title,url

# Don't restrict search attributes at all. This searches for posts
# containing 'WordPress' in all attributes indexed by Algolia. This was
# the behavior of searches prior to June 3, 2015
https://hnrss.org/newest?q=WordPress&search_attrs=default
</pre>

#### Link Parameter

By default, the RSS `<link>` element points to the submitted article's
URL. The `<link>` element can be changed to point to the Hacker News
comment page by appending `link=comments` to the end of the URL. For
example:

<pre>https://hnrss.org/newest?link=comments</pre>

#### Description Parameter

You can disable the `<description>` element entirely by passing the
`description=0` parameter:

<pre>https://hnrss.org/newest?description=0</pre>

#### Count Parameter

By default, feeds return 20 RSS items. This can be increased via the
`count=N` parameter:

<pre>https://hnrss.org/newest?count=50</pre>

There is a hardcoded limit of 100 entries, so keep that in mind.

#### Feed Formats

By default, feeds come back as RSS. But if you add ".atom" or
".jsonfeed" to any endpoint you'll receive the contents in [Atom][] or
[JSON Feed][], respectively.

[Atom]: https://validator.w3.org/feed/docs/atom.html
[JSON Feed]: https://jsonfeed.org/

<pre>
# The front page as Atom
https://hnrss.org/frontpage.atom

# "Ask HN" with 10 or more comments as JSON Feed
https://hnrss.org/ask.jsonfeed?comments=10
</pre>

Note: These formats are a lot less battle-tested than the RSS
format. If you see any wonkiness or they don't play nicely with your
feed reader, please [open an issue](https://github.com/edavis/hnrss/issues/new) with as much information as
possible. Thanks!

## Changelog

### 2018

- August/September 2018
  - Full changelog entry coming soon
- January 2018
  - Add /whoishiring endpoint (h/t [\@jaredandrews](https://github.com/edavis/hnrss/pull/23))

### 2017

- October 2017
  - Add /jobs endpoint.
- April 2017
  - Add python3 support.
  - Improve handling of search feeds with multiple queries.
  - Cleanup docs and move them to Hugo.
  - Fix warnings from the w3.org feed validator.
- March 2017
  - Add support for multiple keywords when searching.
- February 2017
  - Add gzip support.
  - Leave Rackspace, deploy on DigitalOcean.

### 2016

- September 2016
  - Add support for HTTP caching headers.
- July 2016
  - Leave Heroku, deploy on Rackspace.
- April 2016
  - Add /frontpage.

### 2015

- June 2015
  - Set `isPermaLink=false` on `<guid>`.
  - By default, searches now look at post titles.

### 2014

- June 2014
  - Major rewrite, use different URL structure.
- May 2014
  - Launched hnrss.org on Heroku.

## Support

If hnrss.org has made your job or hobby project easier, and you want
to show some gratitude, [donations are very much
appreciated](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=ZP9Q7QUNS3QYY).

Another way to support hnrss.org is to use this [DigitalOcean referral
link](https://m.do.co/c/1c19f7d73361) and receive $10 in credit. Once
you've spent $25 with DigitalOcean, hnrss.org will receive $25 in
credit.

Thanks!

## Credits

Thanks to [Algolia](https://www.algolia.com/) for providing their [REST API][Algolia]. Without it, hnrss.org simply would not exist.

Thanks to [Jared Andrews](https://github.com/jaredandrews) for the [PR](https://github.com/edavis/hnrss/pull/23) that created the /whoishiring/ endpoints.

Thanks to [Zhiming Wang](https://github.com/zmwangx) for adding Python 3 support.

Thanks to [Grant Jenks](https://github.com/grantjenks) for the idea of adding the Article URL and Points to the description.

Thanks to [Chuck Grimmett](https://github.com/cagrimmett) for being a sounding board when it comes to adding new features to hnrss.org as well as suggesting the /jobs endpoint.

And many, many thanks to all those who have donated in support of the project over the years. You all mean the world to me.

## Colophon

hnrss.org is served by nginx on DigitalOcean. HTTPS is provided by Let's
Encrypt. DNS is provided by Namecheap.

As of September 2018, the feeds are generated using the [Gin][] web
framework. From May 2014 to August 2018, the feeds were generated
using the [Flask][] web framework.

[Algolia]: https://hn.algolia.com/api
[Gin]: https://gin-gonic.github.io/gin/
[Flask]: http://flask.pocoo.org/

## Repositories

A brief primer on the various repositories that make up hnrss.org:

When hnrss.org was created in May 2014, code and documentation lived
inside the [edavis/hnrss][] repository.

In April 2017, the documentation was revamped, migrated into Hugo, and
was given its own repository at [edavis/hnrss-docs][]. The built
assets were copied into the `docs/` folder on [edavis/hnrss][] and
published at <https://edavis.github.io/hnrss/>.

In August/September 2018, hnrss.org underwent a rewrite from
Flask to Gin. This new code lives at [edavis/go-hnrss][].

So, as of September 2018, that's the state of play. The documentation
source lives at [edavis/hnrss-docs][]. The Gin source that powers
hnrss.org lives at [edavis/go-hnrss][].

[edavis/hnrss][] contains the Flask code that powered the site
from May 2014 to August 2018 as well as the `docs/` folder that
contains the built HTML copied from [edavis/hnrss-docs][].

At some point I'd like to simplify all of this and run everything out
of one repository, but it'll do for now.

[edavis/hnrss]: https://github.com/edavis/hnrss
[edavis/go-hnrss]: https://github.com/edavis/go-hnrss
[edavis/hnrss-docs]: https://github.com/edavis/hnrss-docs
