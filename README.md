# mikedovale.com — Personal website

This repository contains the **source code and content** for my personal photography website, built with **Hugo** and hosted on **GitHub Pages**.

---

## 📸 About

The site features a gallery of high-resolution film and digital photographs, optimized for both quality and web performance.  
It is designed to be simple, fast, and manually maintainable without relying on heavy CMS systems.

- **Site Engine:** [Hugo](https://gohugo.io/)
- **Theme:** [hugo-theme-gallery](https://github.com/nicokaiser/hugo-theme-gallery)
- **Hosting:** [GitHub Pages](https://pages.github.com/)
- **Domain:** [www.mikedovale.com](https://www.mikedovale.com)

---

## 📂 Repository Structure

```
mikedovale.com/
├── archetypes/
├── content/
│    └── gallery/       # Photo metadata files (.md)
├── layouts/
├── public/             # Built site (linked to gh-pages branch)
├── resources/
│    └── _gen/          # Hugo-generated assets (ignored)
├── static/
│    └── gallery/       # Actual JPEG image files
├── themes/
│    └── hugo-theme-gallery/
├── config.toml         # Site configuration
├── .gitignore
├── CNAME
└── scripts/            # Helper automation scripts
    ├── deploy.sh
    └── replace-photo.sh
```

---

## 🛠️ Local Development

### 1. Install Hugo

Install Hugo (extended version) via [Homebrew](https://brew.sh/) on macOS:

```bash
brew install hugo
```

### 2. Clone the Repo

```bash
git clone git@github.com:mdovale/mikedovale.com.git
cd mikedovale.com
```

### 3. Start Local Server

```bash
hugo server
```

The site will be available at `http://localhost:1313/`.

---

## 🚀 Deployment Workflow

### Regular Site Update (Add Photos, Content Changes)

```bash
./scripts/deploy.sh
```

This script will:
- Clean build caches
- Rebuild the Hugo site
- Commit and push changes to the `gh-pages` branch

✅ Your live website will update automatically.

---

## 🖼️ Replacing an Existing Photo (Without Repo Bloat)

If you create a better edit of an existing photo:

1. Replace the `.jpg` file manually inside `static/gallery/`.
2. Run:

```bash
./scripts/replace-photo.sh static/gallery/your-photo.jpg
```

This script will:
- Purge the old photo from Git history
- Stage and commit the new photo
- Force push to GitHub

✅ Keeps the repository size optimized.

---

## 🛡️ Important Notes

- **Do not manually edit the `/public/` folder** except via Hugo builds.
- **All content and maintenance happen on `main` branch**.
- **Deployment happens via `gh-pages` branch**.

---

## 📄 License

Content (photographs and text) © 2025 Mike Dovale.  
All rights reserved.

Source code for the site itself (configuration, scripts) may be adapted under the [MIT License](https://opensource.org/licenses/MIT).

---
