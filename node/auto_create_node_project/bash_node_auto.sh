#!/bin/bash

# Make project
read name_project
`mkdir $name_project`
cd $name_project

# Initial
npm init -y
touch server.js
touch README.md
npm i express dotenv body-parser pug multer --save
npm jsonwebtoken --save
npm node-localstorage --save

# Make folder
mkdir config
mkdir api
mkdir models
mkdir controllers
mkdir routes
mkdir middlewares
mkdir validate
mkdir public
mkdir views

# Touch file in ./
touch .gitignore
touch .env

# File server.js
echo -e "require('dotenv').config; 
		\nconst port = process.env.PORT || 3000; \nconst express = require('express');
		\n// ROUTES
		\nconst app = new express();
		\n// Connect Database
		\napp.use(express.static('public'));
		\n// MIDDLEWARE \napp.use(express.json()); // for parsing application/json\napp.use(express.urlencoded({ extended: true })); // for parsing application/x-www-form-urlencoded
		\n// VIEWS \napp.set('view engine', 'pug'); \napp.set('views', './views');
		\napp.get('/', async (req, res) => { res.render('index', { name: 'Ductn' }); } );
		\napp.listen(port, () => console.log('Server running on port ' + port));
	" > server.js

# README
echo "# README please !!!" > README.md

# File .gitignore
echo -e "# node_modules \nnode_modules 
		\n# dotenv \n.env 
	" > .gitignore


# views
cd views
touch index.pug
echo "h1 Hello #{name}" > index.pug
mkdir layouts
cd layouts
touch common.pug
cd ../..

# public
cd public
mkdir style
mkdir js
mkdir image
cd ..

# git
git init
git add .
git commit -m "Initial Project"

# Visit my website
xdg-open https://ductn.info
