# specHelpers-imports injected by uRequire:spec task
define ->
  describe """
    uRequire's `rootExports` & `noConflict():`
      (running on #{if __isNode then 'nodejs' else 'Web'} via #{if __isAMD then 'AMD' else 'noAMD/script'}):
    """, ->

      uExLocal = require 'urequire-example'

      it "registers globals 'urequireExample' & 'uEx'", ->
        equal window.urequireExample, uExLocal
        equal window.uEx, uExLocal

      # `window.urequireExample` & `window.uEx` must be set on browser
      # BEFORE loading 'urequire-example' (in SpecRunner_XXX.html)
      it "noConflict() returns module & sets old values to globals 'urequireExample', 'uEx'", ->
        equal window.uEx.noConflict(), uExLocal

        if __isWeb # work only on browser
          equal window.urequireExample, "Old global `urequireExample`"
          equal window.uEx, "Old global `uEx`"

      describe " 'urequire-example' has:", ->

        it "person.fullName()", ->
          equal uExLocal.person.fullName(), 'John Doe'

        it "person.age", ->
          equal uExLocal.person.age, 40

        it "add function", ->
          tru _.isFunction uExLocal.add
          equal uExLocal.add(20, 18), 38
          equal uExLocal.calc.add(20, 8), 28

        it "calc.multiply", ->
          tru _.isFunction uExLocal.calc.multiply
          equal uExLocal.calc.multiply(18, 2), 36

        it "person.eat food", ->
          equal uExLocal.person.eat('food'), 'ate food'

        it "has VERSION", ->
          fals _.isEmpty uExLocal.VERSION