# All imports can be automatically injected via urequire-rc-import
# See 'specHelpers' imports injected by uRequire:spec task

uExLocal = require 'urequire-example'

describe " 'urequire-example' has:", ->

  it "person.fullName()", ->
    eq uExLocal.person.fullName(), 'John Doe'

  it "person.age", ->
    eq uExLocal.person.age, 40

  it "add function", ->
    tru _.isFunction uExLocal.add
    eq uExLocal.add(20, 18), 38
    eq uExLocal.calc.add(20, 8), 28

  it "calc.multiply", ->
    tru _.isFunction uExLocal.calc.multiply
    eq uExLocal.calc.multiply(18, 2), 36

  it "person.eat food", ->
    eq uExLocal.person.eat('food'), 'ate food'

  it "VERSION `#{uExLocal.VERSION}`, #{
      if __isNode
        "running on node, is the exact `package.version`."
      else
        "NOT running on node, it just exists."
  }", ->
    if __isNode
      eq uExLocal.VERSION, JSON.parse(require('fs').readFileSync process.cwd() + '/package.json').version
    else
      ok uExLocal.VERSION

