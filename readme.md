Roots-ignore
=============================

[![npm](https://badge.fury.io/js/roots-ignore.png)](http://badge.fury.io/js/roots-ignore)
[![tests](https://travis-ci.org/carrot/roots-ignore.png?branch=master)](https://travis-ci.org/carrot/roots-ignore)
[![dependencies](https://david-dm.org/carrot/roots-ignore.png?theme=shields.io)](https://david-dm.org/carrot/roots-ignore)
[![Coverage Status](https://img.shields.io/coveralls/carrot/roots-ignore.svg)](https://coveralls.io/r/carrot/roots-ignore?branch=master)

A helper module for selectively compiling a roots project to improve speed in
development.

> **Note:** This project is in early development, and versioning is a little
> different. [Read this](http://markup.im/#q4_cRZ1Q) for more details.

### Why Should You Care?

Building sites is great with [roots](http://roots.cx/), but once your site gets
large enough compile speeds start to slow down, greatly hampering developer
productivity.

Roots-ignore provides an easy way for developers bundle different ignore rules
together, and then quickly comment in/out each bundle while they're developing
in order to have roots ignore different parts of the site during compilation.

### Installation & Usage

- make sure you are in your roots project directory
- `npm install roots-ignore --save`
- define your `app.coffee` config object
- pass it into the ignore function along with the ignore rules
- export the resulting app object

This library should be loaded into your app.coffee, and accepts your app object
as an argument along with an array of the "bundles" you wish to ignore.

Ignore rules are defined in a file called `ignore.coffee` at the root of your
project. This file should export an object with your ignore rules. Each key of
the object is available as an argument to pass into the array.

**Configuring app.coffee**

For example I could have an `app.coffee` file with the following:

```coffee
yaml    = require 'roots-yaml'
ignore  = require 'roots-ignore'

app =
  extensions: [
    yaml()
  ]

  locals:
    wow: 'such local'

ignore app, [
  'blog'
  'case_studies'
  'coding'
  'single'
  'netlify'
]

module.exports = app
```

Sometimes you'll want to have the ignore rules apply only for a specific roots
environment. Simply require the main `app.coffee` file and then pass that into
the ignore function.

```coffee
app     = require './app'
ignore  = require 'roots-ignore'

ignore app, [
  'blog'
  'case_studies'
  'coding'
  'single'
  'netlify'
]

module.exports = app
```

**Creating ignore rules**

Ignore rules are defined in an object exported by `ignore.coffee`. For example:

```coffee
module.exports =
  blog:
    files: ['blogging/**/*', 'views/blogging*']
    extensions: ['RootsContentful']
    locals:
      contentful:
        wow: 'such stub'
    hook: (app) ->
      # do whatever you want here

  coding:
    files: ['coding/**/*', 'views/coding*']

  single:
    files: ['single/**/*', 'assets/css/single/**/*', 'assets/js/single/**/*']

  netlify:
    extensions: ['RootsNetlify']

  case_studies:
    files: ['case_studies/**/*', 'views/casestudies*', 'views/target*', 'views/work*']
```

### Ignore Rule Configuration

Each ignore rule can be configured as follows:

##### files

takes an array of minimatch patterns and adds it to roots `ignores`.

##### extensions

takes an array of extension class names and removes them from the compile process.

##### locals

takes an object that's merged into the roots local objects. good for stubbing
data that's no longer present due to an extension being removed.

###### hook

takes a function that accepts the roots `app` object as an argument. you can
hook into here and manipulate the app object any other way you want.

### License & Contributing

- Details on the license [can be found here](LICENSE.md)
- Details on running tests and contributing [can be found
  here](contributing.md)
