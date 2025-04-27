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

# Stage all changes
git add .

# Create a new commit
commit_message="Update site: $(date '+%Y-%m-%d %H:%M:%S')"
git commit -m "$commit_message"

# Push to gh-pages branch
git push origin gh-pages

echo "🚀 Deployed successfully to GitHub Pages!"