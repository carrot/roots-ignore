ignore = require '../../..'
yaml   = require 'roots-yaml'

app =
  ignores: ["**/_*", "**/.DS_Store"]
  extensions: [
    yaml()
  ]
  locals:
    wow: "original local"

ignore app, [
  'blog'
  'case_studies'
]

module.exports = app
