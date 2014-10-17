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

  it "has some VERSION", ->
    fals _.isEmpty uExLocal.VERSION

  it "has the correct homeHTML", ->
    eq uExLocal.homeHTML, '<html><body><div id="Hello,">Universe!</div><ul><li>Leonardo</li><li>Da Vinci</li></ul></body></html>'