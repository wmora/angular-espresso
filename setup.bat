echo "Installing node modules..."
npm install

echo "Setting up required folders..."
mkdir public\styles

echo "Removing unnecessary stuff..."
del .gitignore
del README.md

echo "Building project..."
cake build

echo "Done! now run your project with 'node app' or 'cake run' and build something awesome!"