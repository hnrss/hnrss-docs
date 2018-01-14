# Hacker News RSS feeds

## Overview

hnrss.org provides custom, realtime RSS feeds for [Hacker News][].

The following feeds are available:

- **Firehose** -- Every new [post](https://hnrss.org/newest) and [comment](https://hnrss.org/newcomments) as it arrives.
- **Front Page** -- [Posts](https://hnrss.org/frontpage) appearing on the front page.
- **Searches** -- New [posts](https://hnrss.org/newest?q=git) and [comments](https://hnrss.org/newcomments?q=django) matching a given search term.
- **Points** -- [Posts](https://hnrss.org/newest?points=300) with more than N points.
- **Activity** -- [Posts](https://hnrss.org/newest?comments=250) with more than N comments.
- **Self-posts** -- All "[Ask HN][]" and "[Show HN][]" posts, along with [polls][].
- **Jobs** -- All [hiring posts][jobs] made by YC startups along with comments from the monthly ["Who is hiring?"][whoishiring] threads.
- **Users** -- New [posts](https://hnrss.org/submitted?id=tokenadult) and [comments](https://hnrss.org/threads?id=tptacek) made by a given user.
- **Threads** -- Each new comment made [in a given thread](https://hnrss.org/item?id=7864813).

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

If the firehose feeds are a bit too noisy for you, read below on
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

- https://hnrss.org/newest?q=Wordpress -- Search for posts with
  "Wordpress" in the title only.
- https://hnrss.org/newest?q=Wordpress&search_attrs=url -- Search for
  posts with 'Wordpress' in the URL only.
- https://hnrss.org/newest?q=Wordpress&search_attrs=title,url -- Search
  for posts with 'Wordpress' in the title or URL.
- https://hnrss.org/newest?q=Wordpress&search_attrs=default -- Don't
  restrict search attributes at all. This searches for posts
  containing 'Wordpress' in all attributes indexed by Algolia. This
  was the behavior of searches prior to June 3, 2015.

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

## ChangeLog

- January 2018
  - Add /whoishiring endpoint (via [@jaredandrews](https://github.com/jaredandrews))
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
- September 2016
  - Add support for HTTP caching headers.
- July 2016
  - Leave Heroku, deploy on Rackspace.
- April 2016
  - Add /frontpage.
- June 2015
  - Set `isPermaLink=false` on `<guid>`.
  - By default, searches now look at post titles.
- June 2014
  - Major rewrite, use different URL structure.
- May 2014
  - Launched hnrss.org on Heroku.

## Support

While running hnrss is by no means “breaking the bank,” every little
bit helps for when the monthly hosting bill or domain registration
renewal comes due. So if the project has made your job or hobby
project easier and you want to show some gratitude, donations are very
much appreciated. Thanks!

[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=ZP9Q7QUNS3QYY)

## Credits & Colophon

hnrss.org uses [Algolia][] to query Hacker News and generate the
feeds. The code is a [Flask][] app. It runs on [nginx][] with
[Varnish][] providing a cache layer and [Let's Encrypt][] providing
HTTPS.

This documentation is built with [Hugo][], rendered using the
[Go font family][], and hosted on Github Pages.

The source of [the app][github-hnrss] and [the documentation][github-hnrss-docs] are hosted on Github.

[Algolia]: https://hn.algolia.com/api
[Flask]: http://flask.pocoo.org/
[nginx]: http://nginx.org/
[Varnish]: http://varnish-cache.org/
[Let's Encrypt]: https://letsencrypt.org/
[Hugo]: https://gohugo.io/
[Go font family]: https://blog.golang.org/go-fonts
[github-hnrss]: https://github.com/edavis/hnrss
[github-hnrss-docs]: https://github.com/edavis/hnrss-docs
