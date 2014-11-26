# All specHelper imports are injected via `urequire-rc-import`
# See 'specHelpers' imports in uRequire:spec task

# `uEx` var injected by `dependencies: imports`

describe " 'urequire-example' has:", ->

  it "person.fullName()", ->
    eq uEx.person.fullName(), 'John Doe'

  it "person.age", ->
    eq uEx.person.age, 40

  it "add function", ->
    tru _.isFunction uEx.add
    eq uEx.add(20, 18), 38
    eq uEx.calc.add(20, 8), 28

  it "calc.multiply", ->
    tru _.isFunction uEx.calc.multiply
    eq uEx.calc.multiply(18, 2), 36

  it "person.eat food", ->
    eq uEx.person.eat('food'), 'ate food'

  it "VERSION `#{uEx.VERSION}`, #{
      if __isNode
        "running on node, is the exact `package.version`."
      else
        "NOT running on node, it just exists."
  }", ->
    if __isNode
      eq uEx.VERSION, JSON.parse(require('fs').readFileSync process.cwd() + '/package.json').version
    else
      ok uEx.VERSION

