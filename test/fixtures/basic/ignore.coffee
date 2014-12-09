module.exports =
  blog:
    files: ['blogging/**/*', 'views/blogging*']
    extensions: ['RootsContentful']
    locals:
      contentful: contentful_stub
    hook: (app) ->

  case_studies:
    files: ['case_studies/**/*']
