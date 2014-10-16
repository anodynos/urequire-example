# All imports can be automatically injected via urequire-rc-import
# See 'specHelpers' imports injected by uRequire:spec task

uExLocal = require 'urequire-example'

describe "uRequire:", ->

  describe """
    `rootExports` & `noConflict():` # (running on #{
      if __isNode then 'nodejs' else 'Web'} via #{if __isAMD then 'AMD' else 'noAMD/script'}):
    """, ->

      it "registers globals 'urequireExample' & 'uEx'", ->
        eq window.urequireExample, uExLocal
        eq window.uEx, uExLocal

      # `window.urequireExample` & `window.uEx` must be set on browser
      # BEFORE loading 'urequire-example' (in SpecRunner_XXX.html)
      it "noConflict() returns module & sets old values to globals 'urequireExample', 'uEx'", ->
        eq window.uEx.noConflict(), uExLocal

        if (__isWeb? and __isWeb) # work only on browser
          eq window.urequireExample, "Old global `urequireExample`"
          eq window.uEx, "Old global `uEx`"

  describe "'import' RC imports module keys as local vars:", ->
    it "`_.isFunction` imported", ->
      tru isFunction ->
      eq isFunction, _.isFunction

    it "`chai.expect` imported", ->
      expect(expect).to.be.a('Function')