#!/bin/bash

# clean-build.sh
# Safely clean old Hugo build artifacts and rebuild the site

# Exit immediately if a command exits with a non-zero status
set -e

echo "🧹 Cleaning old Hugo build outputs..."

# Remove common build artifacts
rm -rf public/
rm -rf resources/_gen/
rm -rf .cache/
rm -f .hugo_build.lock

echo "✅ Cleaned."

# Rebuild the site
echo "🏗️  Rebuilding Hugo site..."
hugo

echo "🚀 Build complete! Fresh site generated in /public/"