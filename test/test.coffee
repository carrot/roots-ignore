path      = require 'path'
fs        = require 'fs'
should    = require 'should'
Roots     = require 'roots'
_path     = path.join(__dirname, 'fixtures')
RootsUtil = require 'roots-util'
h = new RootsUtil.Helpers(base: _path)

# setup, teardown, and utils

compile_fixture = (fixture_name, done) ->
  @public = path.join(fixture_name, 'public')
  h.project.compile(Roots, fixture_name, -> done())

before (done) ->
  h.project.install_dependencies('*', done)

after ->
  h.project.remove_folders('**/public')

# tests

describe 'development', ->

  before (done) -> compile_fixture.call(@, 'basic', done)

  it 'ignores files listed in the ignore rules', ->
    p = path.join(@public, 'blog', 'index.html')
    h.file.exists(p).should.not.be.ok

  it 'ignores the ignore.coffee file', ->
    p = path.join(@public, 'ignore.coffee')
    h.file.exists(p).should.not.be.ok

  it "removes the roots yaml extension according to the ignore rules", ->
    # without roots-yaml extension the yaml files should copy over instead
    # of being ignored
    p = path.join(@public, 'data', 'doge.yaml')
    h.file.exists(p).should.be.ok

  it "merges locals according to the ignore rules", ->
    p = path.join(@public, 'index.html')
    h.file.contains(p, 'such stub').should.be.true

  it "should run the hook function", ->
    p = path.join(@public, 'index.html')
    h.file.contains(p, 'manatoge').should.be.true
