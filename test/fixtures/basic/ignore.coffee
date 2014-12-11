module.exports =
  blog:
    files: ['blog/**/*']
    extensions: ['RootsYAML']
    locals:
      wow: 'such stub'
    hook: (app) ->
      app.locals.hook = 'manatoge'
