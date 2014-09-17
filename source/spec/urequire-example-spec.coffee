
define ->
  describe """
    uRequire's `rootExports` & `noConflict():`
      (running on #{if __isNode then 'nodejs' else 'Web'} via #{if __isAMD then 'AMD' else 'noAMD/script'}):
    """, ->

      uExLocal = require 'urequire-example'

      it "registers globals 'urequireExample' & 'uEx'", ->
        expect( window.urequireExample ).to.equal uExLocal
        expect( window.uEx ).to.equal uExLocal

      # `window.urequireExample` & `window.uEx` must be set on browser
      # BEFORE loading 'urequire-example' (in SpecRunner_XXX.html)
      it "noConflict() returns module & sets old values to globals 'urequireExample', 'uEx'", ->
        expect( window.uEx.noConflict() ).to.equal uExLocal

        if __isWeb # work only on browser
          expect( window.urequireExample ).to.equal "Old global `urequireExample`"
          expect( window.uEx ).to.equal "Old global `uEx`"

      it " 'urequire-example' has teh right properties", ->
        equal uExLocal.person.age, 40
        tru _.isFunction uExLocal.add