#!/bin/bash

# replace-photo.sh
# Safely replace a photo in Hugo site without bloating Git history

# Exit immediately if any command fails
set -e

if [ -z "$1" ]; then
  echo "Usage: ./replace-photo.sh <relative/path/to/photo.jpg>"
  exit 1
fi

PHOTO_PATH="$1"

# Confirm action
echo "⚠️  You are about to permanently remove '$PHOTO_PATH' from Git history and replace it."
read -p "Are you 100% sure? (yes/no): " CONFIRMATION

if [ "$CONFIRMATION" != "yes" ]; then
  echo "❌ Cancelled."
  exit 1
fi

# Check if git-filter-repo is installed
if ! command -v git-filter-repo &> /dev/null; then
  echo "❌ git-filter-repo not found. Install it first (brew install git-filter-repo)."
  exit 1
fi

# Step 1: Remove old file from Git history
echo "🚀 Running git-filter-repo to purge '$PHOTO_PATH'..."
git filter-repo --path "$PHOTO_PATH" --invert-paths

# Step 2: Stage the new file
echo "📸 Adding updated photo..."
git add "$PHOTO_PATH"

# Step 3: Commit the change
echo "📝 Committing replacement..."
git commit -m "Replace photo: $(basename "$PHOTO_PATH") with new edit"

# Step 4: Force push the updated history
echo "🚀 Force pushing updated repo to GitHub..."
git push --force

echo "✅ Photo replacement completed successfully!"