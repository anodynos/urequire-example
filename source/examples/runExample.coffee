fs = require 'fs'
_ = (_B = require 'uberscore')._

for buildPath in [
  'build/UMD/urequire-example'
  'build/minified/urequire-example-min'
]
  try
    if fs.existsSync require.resolve('../../' + buildPath)
      console.log "\nabout to `require('#{buildPath}')`"
      try
        delete global.urequireExample
        delete global.uEx
        uEx_local = require '../../' + buildPath
        l = new _B.Logger "Example '#{buildPath}'"
        l.log 'Global urequireExample is', urequireExample
        l.log 'Global urequireExample == uEx', uEx is urequireExample
        l.log 'Global === local', uEx_local is urequireExample

        l.ok "Successfully loaded mylib v#{uEx_local.VERSION} from: '#{buildPath}'"
        if uEx_local.person.age is 40
          l.ok "Person age is correctly 40"
        else
          l.err "Person age is incorrectly #{uEx_local.person.age}"
      catch err
        console.error "\u001b[31m Error in buildPath #{buildPath}:", err, '\u001b[0m'
  catch err
    console.log "...missing buildPath #{buildPath}"
