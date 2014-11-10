module.exports = gruntFunction = (grunt) ->
  gruntConfig =
    urequire:
      _all:
        dependencies:
          paths: bower: true
          imports: {lodash: ['_']}
        template: banner: true

      UMD:
        path: "source/code"
        resources: [ 'inject-version' ]
        dependencies:
          node: ['nodeOnly/*']
        dstPath: "build/UMD"
        template: 'UMDplain'

      min:
        derive: 'UMD'
        dstPath: "build/minified/urequire-example-min.js"
        template: name: 'combined'
        optimize: true
        rjs: preserveLicenseComments: false

      spec:
        derive: []
        path: "source/spec"
        dstPath: "build/spec"
        dependencies: imports:
          chai: 'chai'
          uberscore: '_B'
          'urequire-example': ['uEx']
          'specHelpers': 'spH'
        rjs: shim:
          uberscore: { deps: ['lodash'], exports: '_B'}
        resources: [
          ['import-keys',
            'specHelpers': [ 'tru', ['equal', 'eq'], 'fals', 'ok' ]
            'chai': ['expect'] ] ]
        afterBuild: require('urequire-ab-specrunner').options
          injectCode: 'window.urequireExample = "Old global `urequireExample`";'
          debugLevel: 100

      specMin:
        derive: 'spec'
        dstPath: "build/spec_combined/index-combined.js"
        template: name: 'combined'

      specWatch: derive: 'specMin', watch: true

  _ = require 'lodash'
  splitTasks = (tasks)-> if _.isArray tasks then tasks else _.filter tasks.split /\s/
  grunt.registerTask shortCut, "urequire:#{shortCut}" for shortCut of gruntConfig.urequire
  grunt.registerTask shortCut, splitTasks tasks for shortCut, tasks of {
    default: "UMD spec min specMin"
    all: "UMD spec UMD specMin min spec min specMin"
  }
  grunt.loadNpmTasks task for task of grunt.file.readJSON('package.json').devDependencies when task.lastIndexOf('grunt-', 0) is 0
  grunt.initConfig gruntConfig