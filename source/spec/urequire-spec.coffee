uExLocal = require 'urequire-example'

describe "uRequire:", ->

  describe """
    uRequire's `rootExports` & `noConflict():` (running on #{
      if __isNode then 'nodejs' else 'Web'} & loading via #{ if __isAMD then 'AMD' else 'noAMD/script' }):
    """, ->
      # `window.urequireExample` set on HTML
      urequireExample = require 'urequire-example'

      it "registers globals - RUNS only `if __isWeb and !__isAMD` ", ->
        if __isWeb and !__isAMD
          eq window.urequireExample, uExLocal

      it "Doesn't register globals & noConflict on AMD (RUNS only `if __isAMD and !__isNode`) ", ->
        if __isAMD and !__isNode
          eq window.urequireExample, "Old global `urequireExample`"

      it  "`noConflict()` returns module & sets old values (NOT only `if __isAMD and !__isNode`)", ->
        if !__isAMD and !__isNode
          eq window.urequireExample.noConflict(), uExLocal
          eq window.urequireExample, "Old global `urequireExample`"

  describe "'import-keys' ResourceConverter imports keys as local vars:", ->
    it "`chai.expect` imported", ->
      expect(expect).to.be.a('Function') # ;-)