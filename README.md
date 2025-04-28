
# mikedovale.com website

## Overview

This is the source repository for [MikeDovale.com](https://www.mikedovale.com/), a professional photography gallery site powered by [Hugo](https://gohugo.io/) and the [hugo-theme-gallery](https://github.com/nicokaiser/hugo-theme-gallery) theme.

✅ Hugo project (main branch)  
✅ Built website (gh-pages branch)  
✅ Clean, minimal setup optimized for fast, scalable galleries.


## Repository Structure

```
mikedovale.com/
├── archetypes/
├── content/
│    ├── andrea-2020/        # One gallery = one Page Bundle
│    │    ├── index.md
│    │    ├── andrea-3516.jpg
│    │    ├── andrea-4114.jpg
│    │    └── (...)
│    ├── jamy-2020/
│    │    ├── index.md
│    │    └── (...)
│    └── _index.md            # Home listing page
├── layouts/
├── public/                   # Built site (gh-pages branch)
├── resources/
├── static/                   # Static assets (logos, CSS if needed)
├── themes/
│    └── hugo-theme-gallery/
├── config.toml
├── .gitignore
├── CNAME                     # Custom domain: www.mikedovale.com
├── scripts/
│    ├── deploy.sh             # One-command deploy
│    └── replace-photo.sh      # Cleanly replace/update photo
└── README.md                  # This file
```


## How Galleries Work

- Each gallery is a **Page Bundle** under `content/`.
- Each gallery lives in its own folder: e.g., `content/andrea-2020/`
- Inside each gallery folder:
  - `index.md` defines the gallery metadata.
  - Images (`.jpg`) are placed alongside the `index.md`.
- No manual list of images is needed. Hugo automatically detects all images via `.Resources`.

**Minimal `index.md` example:**

```markdown
---
title: "Andrea (2020)"
date: 2022-10-02T00:00:00
description: "A tender and introspective portrait session with Andrea, captured in soft natural light."
resources:
  - src: andrea-3516.jpg
    params:
      cover: true
---
```

**Notes:**
- Cover image: Set by marking an image `cover: true`.
- Lightbox and justified layout are built-in.
- SEO and Open Graph meta are automatic.


## Workflow

| Action                     | Command |
|:---------------------------|:--------|
| Build and preview locally  | `hugo server` |
| Build production site      | `hugo` |
| Deploy to GitHub Pages     | `./scripts/deploy.sh` |
| Replace a photo cleanly    | `./scripts/replace-photo.sh path/to/photo.jpg` |


## Theme Setup

- [hugo-theme-gallery](https://github.com/nicokaiser/hugo-theme-gallery) installed as a Git submodule.
- No theme modifications are needed if using the expected Page Bundle structure.
- Follow theme guidelines: images directly inside `content/album-name/`, not inside `static/`.


## Hosting

- Website hosted via GitHub Pages.
- Source (`main` branch) separated from built site (`gh-pages` branch).
- CNAME points to `www.mikedovale.com`.


## Important Notes

- Never manually modify `/public/` — it is auto-generated.
- Stick to folder naming conventions: lowercase, hyphens instead of spaces.
- Future improvements may include automatic image resizing pipelines.


---