# Writing the blog

The website’s **Blog** tab opens an article list. Clicking a title opens the full post. Rebuilding the blog updates this list automatically, with the newest posts first.

Write and edit posts in `_blog/`. Quarto, the software used to build the blog, turns these `.qmd` text files into web pages in `blog/`. Do not edit files in `blog/` directly: rebuilding replaces them.

## Your China AI safety post

Edit `_blog/china-ai-safety.qmd`, then double-click `render-blog.command` in Finder or run it from Terminal in the website folder:

```sh
./render-blog.command
```

The article appears at `blog/china-ai-safety.html`. Its four figures live in `_blog/assets/china-ai-safety/`, and its layout is in `_blog/china-ai-safety.css`. The figure files and article stylesheet were recovered from the HTML you supplied. Quarto regenerates the article’s HTML from the `.qmd` source and places it in `blog/`; the imported HTML is no longer kept beside the source.

## Add another post

Create a file such as `_blog/my-next-post.qmd`. Start with:

```yaml
---
title: "My next post"
description: "A short summary for the article list."
author: "Cheryl Wu"
date: 2026-09-22
categories: [Notes]
draft: true
---
```

Replace the title, summary, and date, then write your article below the closing `---`. Use lowercase filenames with hyphens; the filename becomes part of the article’s web address. Quarto supports headings, links, images, equations, footnotes, and tables.

For posts with several images, you can instead copy `_blog/posts/first-post/` to a new folder such as `_blog/posts/my-next-post/`. Edit its `index.qmd` and put images beside it. This template includes formatting examples and starts as a draft.

When the article is ready, change `draft: true` to `draft: false`, then run `render-blog.command`. Both folder arrangements are included automatically; you do not need to add links by hand. Drafts stay out of the publication list.

## Preview while writing

To see drafts and update the preview as you save, run:

```sh
quarto preview _blog --profile preview --no-browser
```

Open the local address printed in Terminal. This previews the blog only, and drafts have a banner. Press Control-C to stop it. Preview files go into `_blog/_preview/`.

To check the built blog together with the homepage, run this from the website folder after rebuilding:

```sh
python3 -m http.server 8000 --bind 127.0.0.1
```

Open `http://127.0.0.1:8000/` and follow **Blog** to your article. Press Control-C to stop the server.

## Put changes online

The website is hosted on GitHub Pages at [cherylwu3.github.io](https://cherylwu3.github.io/), using the `main` branch of [CherylWu3/CherylWu3.github.io](https://github.com/CherylWu3/CherylWu3.github.io).

`render-blog.command` only builds local files; it does not upload them. After rebuilding, publish the entire `blog/` folder to that repository, including its styles, scripts, and images. The main `index.html` and `photography.html` contain the Blog navigation links.

Keep `_blog/` local because it contains source files and draft previews. Upload the generated `blog/` files instead. You can ask Codex to rebuild and publish your next post using this same setup.

The `.git` files in this Dropbox folder are incomplete, so ordinary Git commands do not work here. The GitHub API provides a working publishing route without replacing this folder’s Git files.

Shared blog colors and fonts are in `_blog/theme.scss`; navigation settings are in `_blog/_quarto.yml`.

References: [Quarto blogs](https://quarto.org/docs/websites/website-blog.html), [automatic article lists](https://quarto.org/docs/websites/website-listings.html), [draft behavior](https://quarto.org/docs/websites/website-drafts.html).
