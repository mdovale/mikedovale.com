#!/bin/bash

set -e

echo "🚨 WARNING: You are about to completely reset and rewrite the gh-pages history!"
echo "This will remove ALL previous commits and rebuild from scratch."
read -p "Are you sure you want to continue? (yes/no) " choice

if [[ "$choice" != "yes" ]]; then
  echo "Aborting."
  exit 1
fi

# Step 1: Clean public/ folder but keep its Git repo
echo "🧹 Cleaning local public/ folder but preserving Git repo..."
cd public/
git rm -r * || true
git clean -fd || true
cd ..
echo "✅ public/ cleaned."

# Step 2: Build fresh Hugo site
echo "🏗️  Building fresh Hugo site..."
hugo
echo "✅ Build complete."

# Step 3: Go into public/
cd public/

# Step 4: Verify we're on gh-pages
BRANCH=$(git symbolic-ref --short HEAD)
if [[ "$BRANCH" != "gh-pages" ]]; then
  echo "❌ Error: Not on gh-pages branch. Exiting."
  exit 1
fi

# Step 5: Completely rewrite history
echo "🔥 Rewriting entire gh-pages history to fresh Hugo build..."

# Safety net: backup current .git just in case (optional)
# cp -r .git ../public-git-backup

# Start filter-repo operation
git filter-repo --force

git remote add origin git@github.com:mdovale/mikedovale.com.git

echo "✅ History rewritten."

# Step 6: Commit fresh build (if needed)
echo "📸 Adding built files..."
git add .

if git diff --cached --quiet; then
  echo "✅ No changes to commit after Hugo build."
else
  git commit -m "Fresh rebuild: $(date '+%Y-%m-%d %H:%M:%S')"
  echo "✅ New build committed."
fi

# Step 7: Force push clean branch
git push origin gh-pages --force
echo "🚀 Force-pushed fresh gh-pages branch."

# Step 8: Return to root
cd ..

# Step 9: Log deployment
DEPLOY_SHA=$(git -C public rev-parse HEAD)
GALLERY_COUNT=$(find content/ -mindepth 1 -maxdepth 1 -type d | wc -l)
IMAGE_COUNT=$(find content/ -iname '*.jpg' | wc -l)

echo "$(date '+%Y-%m-%d %H:%M:%S') - Full reset deployment commit $DEPLOY_SHA | Galleries: $GALLERY_COUNT | Images: $IMAGE_COUNT" >> deployments.log
echo "📜 Logged full reset deployment: Commit $DEPLOY_SHA | Galleries: $GALLERY_COUNT | Images: $IMAGE_COUNT"

echo "🎯 Done! gh-pages repo is now fresh and fully logged."