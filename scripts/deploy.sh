#!/bin/bash

# deploy.sh
# Clean build, commit, and push Hugo site to gh-pages branch

# Exit immediately if any command fails
set -e

echo "🧹 Cleaning build artifacts..."
# Remove build caches
rm -rf resources/_gen/
rm -rf .cache/
rm -f .hugo_build.lock
echo "✅ Clean."

echo "🏗️  Building Hugo site..."
hugo
echo "✅ Build complete."

# Now work inside public/
cd public

echo "📸 Preparing to deploy updated site..."

# Pull any remote changes first to avoid non-fast-forward errors
git pull origin gh-pages --rebase

# Stage all changes
git add .

# Create a new commit
commit_message="Update site: $(date '+%Y-%m-%d %H:%M:%S')"
git commit -m "$commit_message"

# Push to gh-pages branch
git push origin gh-pages

echo "🚀 Deployed successfully to GitHub Pages!"

# Move back to project root
cd ..

# Generate deployment log entry
DEPLOY_SHA=$(git -C public rev-parse HEAD)

# Count galleries (directories directly under content/)
GALLERY_COUNT=$(find content/ -mindepth 1 -maxdepth 1 -type d | wc -l)

# Count images (JPEG files under all galleries)
IMAGE_COUNT=$(find content/ -iname '*.jpg' | wc -l)

# Write to deployments.log
echo "$(date '+%Y-%m-%d %H:%M:%S') - Deployed commit $DEPLOY_SHA | Galleries: $GALLERY_COUNT | Images: $IMAGE_COUNT" >> deployments.log
echo "📜 Logged deployment: Commit $DEPLOY_SHA | Galleries: $GALLERY_COUNT | Images: $IMAGE_COUNT"