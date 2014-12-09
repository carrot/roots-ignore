Roots-ignore
=============================

[![npm](https://badge.fury.io/js/roots-ignore.png)](http://badge.fury.io/js/roots-ignore)
[![tests](https://travis-ci.org/carrot/roots-ignore.png?branch=master)](https://travis-ci.org/carrot/roots-ignore)
[![dependencies](https://david-dm.org/carrot/roots-ignore.png?theme=shields.io)](https://david-dm.org/carrot/roots-ignore)
[![Coverage Status](https://img.shields.io/coveralls/carrot/roots-ignore.svg)](https://coveralls.io/r/carrot/roots-ignore?branch=master)

A roots extension for selectively compiling a project to improve speed in
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

### Installation

- make sure you are in your roots project directory
- `npm install roots-ignore --save`
- modify your `app.coffee` file to include the extension, as such

```coffee
ignore = require('roots-ignore')

module.exports =
  extensions: [
    ignore [
      'blog'
      'case_studies'
      'netlify'
    ]
  ]
```

### Usage

The extension is loaded through `app.coffee` by passing in an array of strings
that specifies which ignore rules should be applied.

Ignore rules are defined in a file called `ignore.coffee` at the root of your
project. This file should export an object with your ignore rules. Each key of
the object is available as an argument to pass into the extension.

**Configuring app.coffee**

For example I could have an `app.coffee` file with the following:

```coffee
ignore  = require 'roots-ignore'

module.exports = 
  extensions: [
    ignore [
      'blog'
      'case_studies'
      'coding'
      'single'
      'netlify'
     ]
  ]
```

It's important that roots-ignore is the first extension to run. Otherwise, you
may have some unexpected results. For example if I'm using the extension in a
specific roots environment, I'd want to make sure to use `unshift` to add the
extension to the main `app.coffee` file. For example

```coffee
app     = require './app'
ignore  = require 'roots-ignore'

module.exports = app
app.extensions.unshift ignore [
  'blog'
  'case_studies'
  'coding'
  'single'
  'netlify'
]
```

**Creating ignore rules**

I can then have an `ignore.coffee` file that looks like this:

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
