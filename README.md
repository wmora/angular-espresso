# Angular Espresso

Start an app with AngularJS on the client, Express + Node + Socket.IO as your back-end, all written in CoffeeScript.

## Current version

Current version: 0.1.0

This version includes the following components:

* AngularJS 1.0.5
* Twitter Bootstrap 2.3.1
* Express 3.1.0
* Socket.IO 0.9.14, client 0.9.11
* Jade 0.28.2
* UglifyJS 2.2.5

## Installation

You need to have installed node (http://nodejs.org/) and CoffeeScript (http://coffeescript.org/), make sure
you install CoffeeScript globally

Once you have them installed, run:
```
npm install
```
## Cakefile Usage

Once you install the dependencies, use the Cakefile for performing different actions:
```
cake build                # Builds app
cake build:module         # Builds the Espresso module
cake build:client         # Builds client scripts
cake clean                # Clean module and client
cake clean:module         # Cleans the Espresso module
cake clean:client         # Cleans the Espresso module
cake run                  # Builds and runs the app
```
## Configuration

There's no configuration for using Angular Espresso, all you need to do is clone/fork the project, install its
dependencies with npm and run your node app.

Your .coffee files should be under the "app" folder. The structure is the following:

NOTE: Each directory has a README file with more detail

* Angular: Your AngularJS app should go in this directory
* Services: Backend logic goes here
* Config: Configuration that may be used to set up different values for a specific environment or a common config
* Routes: This directory should contain the routing functions for your views. Define an entry point for a major
component of your site and then use partials for all its sub-components
* Resources: Any client scripts not related to AngularJS

In the future, I will be adding support for testing. I won't implement file watching until it is stable in node.

## Contribute
If you want to help, fork/clone/share the project, suggest new features, and/or submit pull requests.
Contact me directly at william.r.mora@gmail.com or @wilmor24.

## Author
William Mora - @wilmor24 - http://www.williammora.com

## References

For more on AngularJS: http://angularjs.org

For more on CoffeeScript: http://coffeescript.org

For more on Express: http://expressjs.com

For more on Jade: http://jade-lang.com
