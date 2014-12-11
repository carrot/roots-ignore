path = require 'path'
_    = require 'lodash'

apply_rule = (app, rule) ->
  if not rule then return
  _.defaults(rule, {files: [], extensions: [], locals: {}, hook: ->})
  app.ignores = _.union(app.ignores, rule.files)
  for ext in rule.extensions
    app.extensions = _.reject(app.extensions, (e) -> e.name == ext)
  _.merge(app.locals, rule.locals)
  rule.hook(app)

module.exports = (app, selected_rules) ->
  all_rules = require(path.join(path.dirname(module.parent.id), 'ignore.coffee'))
  app.ignores.push('ignore.coffee')
  for r in selected_rules
    apply_rule(app, all_rules[r])
