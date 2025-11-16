#!/bin/bash
set -e

echo "Building patched Bootstrap 3.4.1 from Debian Bullseye..."

# Build the full image (builder + scratch)
docker build -t bootstrap-debian-builder .

# Run a container from the *builder* stage using --entrypoint
mkdir -p dist_output
docker run --rm \
  -v $(pwd)/dist_output:/output \
  --entrypoint /bin/sh \
  bootstrap-debian-builder \
  -c "cp -r /dist/* /output/"

# Move to final dist
rm -rf dist && mv dist_output dist

# Create package.json
cat > dist/package.json << 'EOF'
{
  "name": "bootstrap-debian",
  "version": "3.4.1-debian-bullseye-patched",
  "main": "js/bootstrap.min.js",
  "style": "css/bootstrap.min.css",
  "license": "MIT"
}
EOF

# Pack
cd dist
npm pack
mv bootstrap-debian-3.4.1-debian-bullseye-patched.tgz ../
cd ..
rm -rf dist

echo "Done! Use: yarn add file:./bootstrap-debian-3.4.1-debian-bullseye-patched.tgz"